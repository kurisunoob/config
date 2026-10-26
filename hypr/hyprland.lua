-- ┏┳┓┏━┓┏┓╻╻╺┳╸┏━┓┏━┓
-- ┃┃┃┃ ┃┃┗┫┃ ┃ ┃ ┃┣┳┛
-- ╹ ╹┗━┛╹ ╹╹ ╹ ┗━┛╹┗╸
--
-- Hyprland 0.56+ Lua 主配置。文档：https://wiki.hypr.land/Configuring/Start/
-- 分片：theme.lua（颜色/外观）、animations.lua、keybindings.lua、rules.lua
--
-- 启动方式：Hyprland 默认只认 $XDG_CONFIG_HOME/hypr/hyprland.lua，
-- 所以要么 hyprctl/module 里指向本文件，要么放一个 hyprland.lua 转发到这里。

-- 配置目录（绝对路径：这样本文件既可以直接用 -c 启动，
-- 也可以从 ~/.config/hypr/hyprland.lua 软链/转发过来 ——
-- require 的搜索目录跟的是“主配置文件所在目录”，相对 require 会找不到）
local HOME = os.getenv("HOME")
local CONFIG = HOME .. "/.config/hypr"
local SCRIPTS = CONFIG .. "/scripts"
local AGS = HOME .. "/.config/ags"

-------------------------------------------------- 显示器
-- 空 output = 兜底规则；VGA-1 直接禁用
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "TabletDisplay", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "VGA-1", disabled = true })

-------------------------------------------------- 环境变量
-- 注意：hl.env 的值必须是字符串（旧配置里写成数字/等号的会被类型检查挡掉）
-- 会话
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Qt / GTK
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- 浏览器 / 其他
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- 显卡（N 卡相关；本机若为纯 iGPU/AMD 可以整段删掉）
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GL_VRR_ALLOWED", "0")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
-- 原来写的是 env = HYPRLAND_NO_SD_NOTIFY=0（逗号写成等号，从未生效）。
-- 这个变量“存在即生效”，写 0 反而会禁用 sd_notify，所以保持注释：
-- hl.env("HYPRLAND_NO_SD_NOTIFY", "1")
-- 指定 DRM 设备才需要：
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/card0")

-------------------------------------------------- 输入 / 布局 / 杂项
hl.config({
	input = {
		kb_layout = "us",
		repeat_rate = 50,
		repeat_delay = 300,

		follow_mouse = 1,
		sensitivity = 0.3, -- -1.0 ~ 1.0，0 = 不修改
		accel_profile = "flat",
		-- 平铺 <-> 浮动 切换时焦点跟随鼠标（2 = 浮动<->浮动 也跟随）
		float_switch_override_focus = 2,

		touchpad = {
			natural_scroll = true,
		},
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

-------------------------------------------------- 触控板手势
-- direction: swipe / horizontal / vertical / left,right,up,down / pinch,pinchin,pinchout
-- action: workspace / move / resize / special / close / fullscreen / float / cursor_zoom ...
hl.gesture({ fingers = 4, direction = "pinch", action = "fullscreen" })
hl.gesture({ fingers = 4, direction = "swipe", action = "move" })
hl.gesture({ fingers = 4, direction = "vertical", mods = "ALT", action = "close" })

hl.gesture({ fingers = 3, direction = "horizontal", action = "resize" })
hl.gesture({ fingers = 3, direction = "up", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = "workspace" })

-- 原 hyprlang 的 `dispatcher, movetoworkspace, r±1` 在新手势 API 里没有对应
-- action，用 lua 函数实现（把窗口挪到上/下一个工作区，自己不动）
hl.gesture({
	fingers = 3,
	direction = "up",
	mods = "ALT",
	action = function()
		hl.dispatch(hl.dsp.window.move({ workspace = "r-1" }))
	end,
})
hl.gesture({
	fingers = 3,
	direction = "down",
	mods = "ALT",
	action = function()
		hl.dispatch(hl.dsp.window.move({ workspace = "r+1" }))
	end,
})

-------------------------------------------------- 开机自启
hl.on("hyprland.start", function()
	-- 让 systemd / portal 继承 wayland 环境
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	-- 脚本（monitor_script.sh 已含 changemonitor.sh 的 --once 逻辑，别再跑两遍）
	hl.exec_cmd(SCRIPTS .. "/resetxdgportal.sh")
	hl.exec_cmd(AGS .. "/themes/init.sh")
	hl.exec_cmd(SCRIPTS .. "/wallpaperdaemon.sh")
	hl.exec_cmd(SCRIPTS .. "/controls.sh")
	hl.exec_cmd(SCRIPTS .. "/monitor_script.sh")

	-- 常驻程序
	hl.exec_cmd("dunst")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("waybar -c ~/.config/waybar/config-river -s ~/.config/waybar/river_style.css")
	hl.exec_cmd("udiskie --tray --automount")

	-- 日志提醒：Hyprland 会把 keybind 冲突等信息写到配置错误里
	-- 检查：hyprctl configerrors
end)

-------------------------------------------------- 分片配置
require(CONFIG .. "/theme") -- 颜色 / 圆角 / 模糊 / GTK 外观
require(CONFIG .. "/animations")
require(CONFIG .. "/keybindings")
require(CONFIG .. "/rules")
