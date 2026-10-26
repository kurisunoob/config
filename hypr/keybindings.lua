-- ╻┏ ┏━╸╻ ╻┏┓ ╻┏┓╻╺┳┓╻┏┓╻┏━╸┏━┓
-- ┣┻┓┣╸ ┗┳┛┣┻┓┃┃┗┫ ┃┃┃┃┗┫┃╺┓┗━┓
-- ╹ ╹┗━╸ ╹ ┗━┛╹╹ ╹╺┻┛╹╹ ╹┗━┛┗━┛
--
-- 按键绑定。文档：https://wiki.hypr.land/Configuring/Basics/Binds/
-- 调度器：https://wiki.hypr.land/Configuring/Basics/Dispatchers/
--
-- flags（第三个参数）：locked 锁屏下也生效 / repeating 按住连发 /
--                      mouse 鼠标拖动类绑定（对应旧的 bindm）
-- 旧配置里 `exec, hyprctl dispatch xxx` 的写法都换成了原生 hl.dsp.*，
-- 不再每次按键 fork 一个 hyprctl 进程。

local SCRIPTS = os.getenv("HOME") .. "/.config/hyprLUA/scripts"

local mainMod = "SUPER"

-------------------------------------------------- 窗口 / 会话
hl.bind(mainMod .. " + Q",   hl.dsp.window.close())
hl.bind(mainMod .. " + W",   hl.dsp.exec_cmd(SCRIPTS .. "/togglefloating.sh"))
hl.bind("ALT + F4",          hl.dsp.window.kill())
hl.bind("ALT + P",           hl.dsp.window.pin())
hl.bind("ALT + return",      hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + L",   hl.dsp.exec_cmd("hyprlock"))

-------------------------------------------------- 启动器 / 取色
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("rofi -show run -show-icons -icon-theme Papirus"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a --format=hex --autocopy"))
-- 下面这些 AGS 侧边栏绑定原来是注释掉的，要用就改成 hl.dsp.exec_cmd(...)
-- hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("ags request sidebar:toggle:home"))

-------------------------------------------------- 常用应用
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd('microsoft-edge-stable --proxy-server="127.0.0.1:7897"'))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("firefox"))

-------------------------------------------------- 音量 / 静音
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(SCRIPTS .. "/volumecontrol.sh -o m"), { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(SCRIPTS .. "/volumecontrol.sh -i m"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(SCRIPTS .. "/volumecontrol.sh -o d"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(SCRIPTS .. "/volumecontrol.sh -o i"), { locked = true, repeating = true })

-------------------------------------------------- 亮度
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(SCRIPTS .. "/brightnesscontrol.sh i"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(SCRIPTS .. "/brightnesscontrol.sh d"), { locked = true, repeating = true })

-------------------------------------------------- 截图
hl.bind(mainMod .. " + P",             hl.dsp.exec_cmd(SCRIPTS .. "/screenshot.sh s"))  -- 拖选区域 / 点窗口
hl.bind(mainMod .. " + CTRL + P",      hl.dsp.exec_cmd(SCRIPTS .. "/screenshot.sh sf")) -- 冻结画面后拖选
hl.bind(mainMod .. " + ALT + P",       hl.dsp.exec_cmd(SCRIPTS .. "/screenshot.sh m"))  -- 当前显示器
hl.bind("Print",                       hl.dsp.exec_cmd(SCRIPTS .. "/screenshot.sh p"))  -- 所有显示器

-------------------------------------------------- 自定义脚本
hl.bind(mainMod .. " + SHIFT + W",
    hl.dsp.exec_cmd("pkill -x rofi || " .. SCRIPTS .. "/wallpaperselect.sh"))            -- 壁纸选择
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pkill -x rofi || " .. SCRIPTS .. "/cliphist.sh c"))  -- 剪贴板

-------------------------------------------------- 焦点移动（ALT + WASD）
hl.bind("ALT + A",   hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + D",   hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + W",   hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + S",   hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.focus({ direction = "down" }))

-------------------------------------------------- 切换 / 移动 工作区（1-9）
for i = 1, 9 do
    local key = tostring(i)
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))                     -- 切换
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))               -- 窗口跟过去
    hl.bind(mainMod .. " + ALT + " .. key,   hl.dsp.window.move({ workspace = i, follow = false })) -- 窗口过去、焦点不动
end

-------------------------------------------------- 相对工作区
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.focus({ workspace = "empty" }))   -- 第一个空工作区

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-------------------------------------------------- 调整窗口大小（按住连发）
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 30,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0, y = 30,  relative = true }), { repeating = true })

-------------------------------------------------- 在工作区内移动窗口（SHIFT + CTRL + WASD）
hl.bind(mainMod .. " + SHIFT + CTRL + A", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + CTRL + D", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + CTRL + W", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + CTRL + S", hl.dsp.window.move({ direction = "down" }))

-------------------------------------------------- 鼠标：拖动 / 缩放窗口
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })  -- 左键拖动
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })  -- 右键缩放

-------------------------------------------------- 特殊工作区（scratchpad）
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("special"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special", follow = false }))

-------------------------------------------------- 其他
-- dwindle 布局的 togglesplit
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- 合盖锁屏（switch 事件作为按键串绑定，和旧 bindl 等价）
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })
