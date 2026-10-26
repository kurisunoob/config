-- ╺┳╸╻ ╻┏━╸┏┳┓┏━╸
--  ┃ ┣━┫┣╸ ┃┃┃┣╸
--  ╹ ╹ ╹┗━╸╹ ╹┗━╸
--
-- 颜色 / 圆角 / 模糊 / GTK 外观。
--
-- 主题切换仍由 AGS 负责：~/.config/ags/themes/sync.sh 会把
-- ~/.config/hypr/themes/<theme>.conf 软链到 ~/.local/state/theme/hypr_theme.conf，
-- 然后 hyprctl reload。那份文件是 hyprlang 格式，所以这里在加载时解析它，
-- 这样换主题不需要改 sync.sh，也不用维护两套主题文件。

local THEME_CONF = os.getenv("HOME") .. "/.local/state/theme/hypr_theme.conf"

-- 解析 hyprlang 主题文件里的三类行：$变量 = 值 / env = NAME,value / exec = 命令
local function read_theme(path)
    local vars, envs, execs = {}, {}, {}

    local file = io.open(path, "r")
    if not file then
        return vars, envs, execs
    end

    -- 注意：Lua 5.5 的 for 循环变量是 const，不能赋值，所以用局部变量承接
    for raw in file:lines() do
        local text = raw:gsub("#.*$", "")

        local name, value = text:match("^%s*%$([%w_]+)%s*=%s*(.-)%s*$")
        if name then
            vars[name] = value
        else
            local env_name, env_value = text:match("^%s*env%s*=%s*([%w_]+)%s*,%s*(.-)%s*$")
            if env_name then
                envs[env_name] = env_value
            else
                local cmd = text:match("^%s*exec%s*=%s*(.-)%s*$")
                if cmd and cmd ~= "" then
                    table.insert(execs, cmd)
                end
            end
        end
    end

    file:close()
    return vars, envs, execs
end

local vars, envs, execs = read_theme(THEME_CONF)

-- 解析变量间接引用：主题文件里是 $active_border_color = $bg2 这种写法
for name, value in pairs(vars) do
    local seen = {}
    while value:match("^%$[%w_]+$") and not seen[value] do
        seen[value] = true
        value = vars[value:sub(2)] or value
    end
    vars[name] = value
end

-- 边框颜色：主题文件里是 $active_border_color / $inactive_border_color
-- （旧转换脚本把它们写成了未定义的裸变量，取到 nil → 边框颜色不生效）
local active_border   = vars.active_border_color   or "rgb(89b482)"
local inactive_border = vars.inactive_border_color or "rgb(3c444a)"

-- 主题自带的 env（例如 env = GTK_THEME,Everforest-Dark）
for name, value in pairs(envs) do
    hl.env(name, value)
end

-- 主题自带的 exec（例如 gsettings set ... gtk-theme）
for _, cmd in ipairs(execs) do
    hl.exec_cmd(cmd)
end

-------------------------------------------------- 光标
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "20")

-------------------------------------------------- 外观
hl.config({
    general = {
        gaps_in       = 4,
        gaps_out      = 10,
        border_size   = 1,
        layout        = "dwindle",
        resize_on_border = true,

        col = {
            active_border   = active_border,
            inactive_border = inactive_border,
        },
    },

    decoration = {
        rounding    = 8,
        dim_special = 0.5,      -- 特殊工作区变暗程度

        blur = {
            enabled = false,
            size    = 8,
            passes  = 2,
            special = true,     -- 特殊工作区也要模糊
        },
    },
})

-------------------------------------------------- 光标 / GTK / 字体
-- 旧配置里这些是 hyprlang 的 `exec =`，每次加载都会跑一遍；这里同样在加载时执行。
-- 注意顺序：主题文件的 exec 在前（上面），下面的固定值在后 —— 和原来
-- hyprland.conf 里 source 的先后顺序一致，也就是说 GTK 主题最终是 phocus，
-- 而不是主题文件里的 Everforest-Dark。想以主题为准就把 gtk-theme 这行删掉。
hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 20")

local gsettings = {
    "cursor-theme 'Bibata-Modern-Ice'",
    "cursor-size 20",
    "icon-theme 'Tela-circle-black'",
    "gtk-theme 'phocus'",
    "color-scheme 'prefer-dark'",
    "font-name 'CaskaydiaCove Nerd Font 9'",
    "document-font-name 'CaskaydiaCove Nerd Font 9'",
    "monospace-font-name 'CaskaydiaCove Nerd Font 9'",
    "font-antialiasing 'rgba'",
    "font-hinting 'full'",
}

for _, setting in ipairs(gsettings) do
    hl.exec_cmd("gsettings set org.gnome.desktop.interface " .. setting)
end
