#!/usr/bin/env bash
# 手动/开机兜底：只执行一次内屏开关逻辑，实际逻辑统一在 monitor_script.sh
exec "$HOME/.config/hypr/scripts/monitor_script.sh" --once
