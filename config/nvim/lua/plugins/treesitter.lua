return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "astro",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "typescript",
        "tsx",
        "vim",
        "vimdoc",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    })
  end,
}
