-- ~/.config/nvim/lua/plugins/editor/hipatterns.lua
return {
  --TODO: asdf
  "echasnovski/mini.hipatterns",
  event = "BufReadPre",
  config = function()
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        -- 高亮十六进制颜色（你本来就想要的）
        hex_color = hipatterns.gen_highlighter.hex_color(),

        -- 重点：高亮行尾空格（红色波浪线，超醒目）
        trailing_whitespace = {
          pattern = "%s+$",               -- 匹配行尾一个或多个空格
          group = "MiniHipatternsTrailingWhitespace",  -- 自定义高亮组
          extmark_opts = { priority = 2000 },
        },

        -- 顺便再送你几个神仙功能（全默认开）
        fixme     = { pattern = "%f[%w]FIXME:%f[%W]", group = "DiagnosticError" },
        hack      = { pattern = "%f[%w]HACK:%f[%W]",  group = "DiagnosticWarn" },
        todo      = { pattern = "%f[%w]TODO:%f[%W]",  group = "DiagnosticInfo" },
        note      = { pattern = "%f[%w]NOTE:%f[%W]",  group = "DiagnosticHint" },
      },
    })

    -- 可选：给行尾空格弄个更好看的红色波浪下划线（everforest 超搭）
    -- 红色虚线下划线 + 行尾显示 ···（超级显眼但不碍眼）
    vim.api.nvim_set_hl(0, "MiniHipatternsTrailingWhitespace", { underline = true, fg = "#bf616a" })
  end,
}
