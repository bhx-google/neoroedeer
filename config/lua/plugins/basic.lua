local function lsp_status()
  return require("lsp-status").status()
end
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
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/lsp-status.nvim" },
    opts = {
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {
          "encoding",
          "fileformat",
          "filetype",
          { lsp_status, draw_empty = true },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  { "sindrets/diffview.nvim" },
  { "echasnovski/mini.pairs", version = false, config = true, opts = {} },
  { "echasnovski/mini.ai", version = false, config = true, opts = {} },
  { "echasnovski/mini.surround", version = false, config = true, opts = {} },
  { "echasnovski/mini.splitjoin", version = false, config = true, opts = {} },
  {
    "MagicDuck/grug-far.nvim",
    config = true,
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>b", group = "build" },
          { "<leader>f", group = "file" },
          { "<leader>t", group = "find / search" },
          { "<leader>x", group = "outline / diagnostics" },
          { "g", group = "goto" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
