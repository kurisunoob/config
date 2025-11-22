-- local lspconfig = require("lspconfig")
--
-- lspconfig.omnisharp.setup({
--   -- cmd = {"mono","/home/tu/.local/share/nvim/mason/packages/omnisharp-mono/omnisharp/OmniSharp.exe" },  -- 确保路径正确
--   -- 可以根据需要添加其他配置选项
-- })
local lspconfig = require('lspconfig')

lspconfig.omnisharp.setup {
    cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
    enable_roslyn_analyzers = true,
    enable_import_completion = true,
    organize_imports_on_format = true,
    filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
    root_dir = function(fname)
        return lspconfig.util.root_pattern("*.sln", "*.csproj")(fname) or lspconfig.util.path.dirname(fname)
    end,
    on_attach = function(client, bufnr)
        -- 这里可以添加更多的 on_attach 逻辑
    end,
    capabilities = capabilities,  -- 确保 capabilities 已定义
}
