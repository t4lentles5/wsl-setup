return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local servers = {
      "ts_ls",    -- TypeScript/JavaScript
      "pyright",  -- Python
      "html",     -- HTML
      "cssls",    -- CSS
      "jsonls",   -- JSON
      "emmet_ls", -- Emmet
    }

    for _, server in ipairs(servers) do
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end

    local root_dir = require("lspconfig").util.root_pattern("package.json")(vim.api.nvim_buf_get_name(0))
    if root_dir then
      lspconfig.astro.setup({
        capabilities = capabilities,
        init_options = {
          typescript = {
            tsdk = root_dir .. "/node_modules/typescript/lib",
          },
        },
      })
    else
      lspconfig.astro.setup({ capabilities = capabilities })
    end

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
        },
      },
    })

    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      filetypes = {
        "html",
        "css",
        "javascriptreact",
        "typescriptreact",
      },
    })
  end,
}
