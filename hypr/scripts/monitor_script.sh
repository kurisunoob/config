#!/bin/bash

handle_event() {
  case $1 in
    monitoradded*|monitorremoved*)
      if hyprctl monitors | grep -q "HDMI-A-1"; then
        hyprctl keyword monitor "HDMI-A-1,preferred,auto,1"
        hyprctl keyword monitor "eDP-1,disable"
      else
        hyprctl keyword monitor "eDP-1,preferred,auto,1"
      fi
            ;;
    esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    handle_event "$line"
done

