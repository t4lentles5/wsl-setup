return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",

  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    local cmp_status_ok, cmp = pcall(require, "cmp")
    if cmp_status_ok then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
