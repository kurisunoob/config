-- ╻ ╻╻┏┓╻╺┳┓┏━┓╻ ╻   ┏━┓╻ ╻╻  ┏━╸┏━┓
-- ┃╻┃┃┃┗┫ ┃┃┃ ┃┃╻┃   ┣┳┛┃ ┃┃  ┣╸ ┗━┓
-- ┗┻┛╹╹ ╹╺┻┛┗━┛┗┻┛   ╹┗╸┗━┛┗━╸┗━╸┗━┛
--
-- 窗口规则 / 工作区规则 / 图层规则
-- 文档：https://wiki.hypr.land/Configuring/Basics/Window-Rules/
--       https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-------------------------------------------------- 工作区规则
-- 特殊工作区：更大的内/外边距
hl.workspace_rule({
    workspace = "special",
    gaps_in   = 24,
    gaps_out  = 64,
})

-- 9 号工作区固定在大屏
hl.workspace_rule({
    workspace = 9,
    monitor   = "TabletDisplay",
})

-------------------------------------------------- 窗口规则（原来全部是注释，这里是等价的 Lua 写法）
-- hl.window_rule({ match = { class = "^(nwg-look)$" },            float = true })
-- hl.window_rule({ match = { class = "^(pavucontrol)$" },         float = true })
-- hl.window_rule({ match = { class = "^(nm-applet)$" },           float = true })
-- hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, float = true })
-- hl.window_rule({ match = { class = "^(com.obsproject.Studio)$", title = "^(Controls)$" }, float = true })

-------------------------------------------------- 图层规则（原来也是注释掉的）
-- hl.layer_rule({ name = "noanim-notifications", match = { namespace = "notifications" }, no_anim = true })
-- hl.layer_rule({ name = "noanim-bar",           match = { namespace = "bar" },           no_anim = true })
-- hl.layer_rule({ name = "noanim-sidebar",       match = { namespace = "sidebar" },       no_anim = true })
-- hl.layer_rule({ name = "noanim-menu",          match = { namespace = "menu" },          no_anim = true })
