#!/bin/bash
if hyprctl monitors | grep -q "HDMI-A-1"; then
  hyprctl keyword monitor "HDMI-A-1,preferred,auto,1"
  hyprctl keyword monitor "eDP-1,disable"
else
  hyprctl keyword monitor "eDP-1,preferred,auto,1"
fi
