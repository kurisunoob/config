#!/bin/bash

# 检查 swww 守护进程是否运行
swww query >/dev/null 2>&1
if [ $? -eq 1 ]; then
  # 启动 swww-daemon 并在后台运行
  swww-daemon &
  
  # 等待守护进程初始化（避免竞争条件）
  sleep 1
  
  # 检查壁纸文件是否存在
  WALLPAPER="$HOME/.config/swww/current.set"
  if [ -f "$WALLPAPER" ]; then
    swww img "$WALLPAPER" \
      --transition-type "wipe" \
      --transition-duration 2
  else
    echo "Error: Wallpaper file $WALLPAPER does not exist."
    exit 1
  fi
else
  echo "swww-daemon is already running."
fi
