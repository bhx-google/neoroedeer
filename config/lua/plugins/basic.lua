return {
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    ---@type solarized.config
    opts = {},
    config = function(_, opts)
      vim.o.termguicolors = true
      vim.o.background = "light"
      require("solarized").setup(opts)
      vim.cmd.colorscheme("solarized")
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        override_vim_notify = true,
      },
      -- options
    },
  },
  {
    "ojroques/nvim-osc52",
    opts = {
      tmux_passthrough = true,
    },
    keys = {
      {
        "<leader>c",
        function()
          require("osc52").copy_operator()
        end,
        expr = true,
        mode = "n",
      },
      {
        "<leader>c",
        function()
          require("osc52").copy_visual()
        end,
        mode = "v",
      },
    },
  },
  { "frace/vim-bubbles" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
  },
}
