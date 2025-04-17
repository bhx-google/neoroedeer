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
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "ojroques/nvim-osc52",
    opts = {
      tmux_passthrough = true,
    },
    keys = {
      {
        "<leader>ey",
        function()
          require("osc52").copy_operator()
        end,
        expr = true,
        mode = "n",
        desc = "Copy to osc52 (normal).",
      },
      {
        "<leader>ec",
        function()
          require("osc52").copy_visual()
        end,
        mode = "v",
        desc = "Copy to osc52 (visual).",
      },
    },
  },
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
    "echasnovski/mini.move",
    version = false,
    config = true,
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<C-h>",
        right = "<C-l>",
        down = "<C-j>",
        up = "<C-k>",

        -- Move current line in Normal mode
        line_left = "<C-h>",
        line_right = "<C-l>",
        line_down = "<C-j>",
        line_up = "<C-k>",
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    config = true,
    opts = {},
    keys = {
      {
        "<leader>er",
        function()
          local grug = require("grug-far")
          grug.open({
            transient = true,
            prefills = {
              paths = vim.fn.expand("%"),
            },
          })
        end,
      },
    },
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
          { "<leader>x", group = "outline / diagnostics." },
          { "<leader>o", group = "Orgmode." },
          { "<leader>d", group = "diff" },
          { "<leader>c", group = "code" },
          { "<leader>e", group = "edit" },
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
