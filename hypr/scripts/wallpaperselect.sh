#!/usr/bin/env sh

# set variables
ScrDir=`dirname "$(realpath "$0")"`
RofiConf="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/wallpaperselect.rasi"
# 注意：这里不要去回退到 ~/.config/rofi/config.rasi。那份全局主题里 *{height:600px}
# 这类尺寸会把 listview 的行挤出窗口，导致 dmenu 一个条目都显示不出来。
wallPath="${XDG_CONFIG_HOME:-$HOME/.config}/swww"
hypr_border="${hypr_border:-0}"
sddmBgDir="/usr/share/sddm/themes/corners/backgrounds"

# scale for monitor x res
x_monres=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .width' 2>/dev/null)
# 注意：scale 现在输出 "1"/"1.5" 这类数字，不能再去掉小数点当整数算，
# 否则图标尺寸被放大 100 倍（43520px），rofi 2.0 的 wayland 后端会直接 segfault
monitor_scale=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .scale' 2>/dev/null)
elem_size=$(awk -v w="${x_monres:-0}" -v s="${monitor_scale:-1}" 'BEGIN {
  if (w <= 0 || s <= 0) { print 200; exit }
  n = int((w * 17) / (s * 100))
  if (n < 48)  n = 48
  if (n > 220) n = 220   # 超过 220 命令行会超出 rofi 窗口，条目就渲染不出来了
  print n
}')

# set rofi override
elem_border=$(( hypr_border * 3 ))
r_override="element{border-radius:${elem_border}px;} listview{columns:6;lines:2;spacing:10px;} element{padding:0px;orientation:vertical;} element-icon{size:${elem_size}px;border-radius:0px;} element-text{padding:20px;}"

# pre-select the currently set wallpaper
currentWall=`basename "$(readlink -f "${wallPath}/current.set" 2>/dev/null)" 2>/dev/null`

# launch rofi menu
RofiSel=$( find -L "${wallPath}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort | while read rfile
do
  echo -en "$rfile\x00icon\x1f${wallPath}/${rfile}\n"
done | rofi -show-icons -dmenu -theme-str "${r_override}" -config "${RofiConf}" -select "${currentWall}" )

# apply wallpaper
if [ ! -z "${RofiSel}" ] ; then
  selected="${wallPath}/${RofiSel}"

  awww img "$selected" \
    --transition-type "wipe" \
    --transition-duration 2

  rm -f "${wallPath}/current.set"
  ln -sfn "$selected" "${wallPath}/current.set"

  # sddm 登录背景：目录存在且可写才处理（写 /usr/share 需要 root），否则跳过
  if [ -d "$sddmBgDir" ] && [ -w "$sddmBgDir" ]; then
    rm -f "${sddmBgDir}/background.png"
    ln -sfn "$selected" "${sddmBgDir}/background.png"
  fi

  dunstify "Changed Wallpaper to ${RofiSel}" -a "Wallpaper" -i "${wallPath}/${RofiSel}" -r 91190 -t 2200
fi
