return {

  { import = "lazyvim.plugins.extras.lang.python" },

  { import = "lazyvim.plugins.extras.lang.toml" },

  { import = "lazyvim.plugins.extras.lang.yaml" },

  { import = "lazyvim.plugins.extras.lang.json" },

  { import = "lazyvim.plugins.extras.lang.docker" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
}
