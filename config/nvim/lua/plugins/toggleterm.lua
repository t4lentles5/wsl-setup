return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      direction = "float",
      size = 20,
      float_opts = {
        border = "curved",
        width = 100,
        height = 25,
        winblend = 0,
      },
      shade_terminals = true,
      start_in_insert = true,

      on_open = function(term)
--        vim.api.nvim_win_set_option(term.window, "winhighlight", "Normal:Normal")
        vim.api.nvim_buf_set_option(term.bufnr, "filetype", "toggleterm")

        vim.api.nvim_buf_set_option(term.bufnr, "modifiable", true)

        vim.api.nvim_buf_set_option(term.bufnr, "modifiable", false)
      end,
    })
  end,
}
