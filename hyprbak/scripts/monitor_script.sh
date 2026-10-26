#!/usr/bin/env bash
# 外接屏插上 -> 关闭笔记本内屏（monitor disable，工作区自动搬到外屏）
# 拔掉外接屏 -> 点亮内屏
#
# 为什么需要轮询兜底：
#   0.56 起 monitor 规则是运行时状态，任何 hyprctl reload 都会把 disable 冲掉、
#   内屏复活（AGS 切主题的 sync.sh 就会调 hyprctl reload）。reload 不产生
#   monitoradded/removed 事件，所以只靠事件监听会出现「两条屏都亮」且不自愈。
#
# 用法： monitor_script.sh          -> 常驻（exec-once 启动）
#        monitor_script.sh --once   -> 只执行一次（手动兜底）

INTERNAL_RE='^(eDP|LVDS|DSI)-[0-9]+$'
EXTERNAL_RE='^(HDMI-A|DP|DVI|VGA)-[0-9]+$'
POLL=5
STATE_DIR="$HOME/.local/state"
LOG_FILE="$STATE_DIR/hypr-monitor-auto.log"
PID_FILE="$STATE_DIR/hypr-monitor-auto.pid"
OFF_FILE="$STATE_DIR/hypr-monitor-auto.off"   # 存在此文件则暂停自动行为

mkdir -p "$STATE_DIR"
log() { printf '[%s] %s\n' "$(date '+%F %T')" "$*" >>"$LOG_FILE"; }

# 物理连接的输出名。/sys 是真值，不受 Hyprland 运行时规则影响。
connected() {
  local f n
  for f in /sys/class/drm/card*-*/status; do
    [ -r "$f" ] || continue
    [ "$(cat "$f" 2>/dev/null)" = "connected" ] || continue
    n=${f%/status}; n=${n##*/}; n=${n#card*-}
    printf '%s\n' "$n"
  done
}

enabled() { hyprctl monitors | grep -q "^Monitor $1 "; }

# 把所有 headless 假输出清掉（恢复内屏时用来强制 Hyprland 重套 monitor 规则）
clean_headless() {
  local h
  for h in $(hyprctl monitors all | awk '/^Monitor HEADLESS-/{gsub(/[()]/,"",$2); print $2}'); do
    hyprctl output remove "$h" >/dev/null 2>&1
  done
}

# 0.56 里内屏被运行时 disable 后，普通 keyword 点不亮；只有 monitor 增删事件
# 会让 Hyprland 重新套用规则（实测 headless 假输出的增删就能触发）。
force_reapply() {
  hyprctl output create headless >/dev/null 2>&1
  sleep 0.6
  clean_headless
  sleep 0.6
}

apply() {
  [ -e "$OFF_FILE" ] && return 0

  local int=() ext=() o
  while read -r o; do
    [[ $o =~ $INTERNAL_RE ]] && int+=("$o")
    [[ $o =~ $EXTERNAL_RE ]] && ext+=("$o")
  done < <(connected)

  (( ${#int[@]} == 0 )) && return 0        # 没内屏（台式机）不管

  if (( ${#ext[@]} == 0 )); then
    for o in "${int[@]}"; do
      enabled "$o" && continue
      hyprctl keyword monitor "$o,preferred,auto,1" >/dev/null 2>&1
      sleep 0.5
      if ! enabled "$o"; then
        force_reapply
        hyprctl keyword monitor "$o,preferred,auto,1" >/dev/null 2>&1
        sleep 0.5
      fi
      enabled "$o" && log "无外接屏 -> 点亮内屏 $o" || log "!! 无法点亮内屏 $o"
    done
    return 0
  fi

  for o in "${int[@]}"; do
    enabled "$o" || continue
    hyprctl keyword monitor "$o,disable" >/dev/null 2>&1
    log "外接 ${ext[*]} 已连接 -> 关闭内屏 $o"
  done
}

# 日志别无限长
if [ -f "$LOG_FILE" ] && [ "$(wc -l <"$LOG_FILE")" -gt 2000 ]; then
  tail -n 500 "$LOG_FILE" >"$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
fi

if [ "${1:-}" = "--once" ]; then
  apply
  exit 0
fi

# 常驻：单实例（用 pid 文件，别用 flock——后台子进程会继承 fd 导致锁永不放）
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE" 2>/dev/null)" 2>/dev/null; then
  log "已有实例在跑 (pid $(cat "$PID_FILE"))，退出"
  exit 0
fi
echo $$ >"$PID_FILE"
trap 'rm -f "$PID_FILE"' EXIT INT TERM

clean_headless
apply

# 1) 热插拔事件
( socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" 2>/dev/null |
  while read -r line; do
    case "$line" in
      monitoradded*|monitorremoved*) sleep 0.8; apply ;;
    esac
  done ) &

# 2) 定时兜底（hyprctl reload / 切主题会重置状态）
while :; do
  sleep "$POLL"
  apply
done
