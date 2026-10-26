-- ┏━┓┏┓╻╻┏┳┓┏━┓╺┳╸╻┏━┓┏┓╻
-- ┣━┫┃┗┫┃┃┃┃┣━┫ ┃ ┃┃ ┃┃┗┫
-- ╹ ╹╹ ╹╹╹ ╹╹ ╹ ╹ ╹┗━┛╹ ╹
--
-- 动画。曲线用 hl.curve(name, spec)，动画用 hl.animation({ leaf, ... })。
-- 文档：https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.config({ animations = { enabled = true } })

-------------------------------------------------- 贝塞尔曲线
hl.curve("wind",   { type = "bezier", points = { { 0.05, 0.9  }, { 0.1,  1.05 } } })
hl.curve("winIn",  { type = "bezier", points = { { 0.76, 0.42 }, { 0.74, 0.87 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.76, 0.42 }, { 0.74, 0.87 } } })
hl.curve("workIn", { type = "bezier", points = { { 0.72, -0.07 }, { 0.41, 0.98 } } })
hl.curve("linear", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

-------------------------------------------------- 动画
hl.animation({ leaf = "windows",          enabled = true, speed = 2, bezier = "workIn", style = "slide" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 2, bezier = "workIn", style = "slide" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 2, bezier = "workIn", style = "slide" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 2, bezier = "winIn",  style = "slide" })

hl.animation({ leaf = "fadeIn",           enabled = true, speed = 2, bezier = "winIn" })
hl.animation({ leaf = "fadeOut",          enabled = true, speed = 2, bezier = "winOut" })

hl.animation({ leaf = "workspaces",       enabled = true, speed = 2, bezier = "workIn", style = "slidevert" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "workIn", style = "slidevert" })
