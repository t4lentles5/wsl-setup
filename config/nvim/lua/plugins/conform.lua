return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        typescript = { "prettier" },
        javascript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        astro = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        python = { "black" },
        sh = { "shfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
}
