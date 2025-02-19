return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      extensions = {
        file_browser = {
          hijack_netrw = true,
        },
        persisted = {
          layout_config = { width = 0.55, height = 0.55 },
        },
      },
      opts_extend = { "defaults.layout_strategy", "defaults.path_display" },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      hijack_netrw = true,
    },
    keys = {
      {
        "<leader>tf",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
      },
      {
        "<leader>tt",
        "<cmd>Telescope file_browser<CR>",
      },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
}
