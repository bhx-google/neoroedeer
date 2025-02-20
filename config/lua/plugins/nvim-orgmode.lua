return {
  "nvim-orgmode/orgmode",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-orgmode/telescope-orgmode.nvim" },
  event = "VeryLazy",
  ft = { "org" },
  opts = {
    org_agenda_files = neoroedeer.extra_options.org.root .. "/**/*.org",
    org_default_notes_file = neoroedeer.extra_options.org.root .. "/refile.org",
    org_todo_keywords = { "TODO(t)", "WAIT(w)", "IN_PROGRESS(i)", "|", "DONE(d)", "CANCEL(c)" },
    org_startup_indented = true,
    org_archive_location = "archive/%s_archive::",
    org_priority_highest = 0,
    org_priority_default = 2,
    org_priority_lowest = 4,
    org_capture_templates = {
      T = {
        description = "Todo",
        template = "* TODO %?\n %u",
        target = "~/notes/orgmode/inbox/todo.org",
      },
    },
    org_todo_keyword_faces = {
      WAIT = ":foreground purple :weight bold",
      TODO = ":background cyan", -- overrides builtin color for `TODO` keyword
      IN_PROGRESS = ":foreground blue :background yellow", -- overrides builtin color for `TODO` keyword
    },
    win_split_mode = "auto",
  },
  config = function(_, opts)
    require("orgmode").setup(opts)
    require("telescope").load_extension("orgmode")

    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    -- add ~org~ to ignore_install
    -- require("nvim-treesitter.configs").setup({
    --   ensure_installed = "all",
    --   ignore_install = { "org" },
    -- })
  end,
  keys = {
    -- We might need the following bindings for alacritty:
    -- [[keyboard.bindings]]
    -- chars = "\u001B[13;2u"
    -- key = "Return"
    -- mods = "Shift"
    --
    -- [[keyboard.bindings]]
    -- chars = "\u001B[13;5u"
    -- key = "Return"
    -- mods = "Control"
    {
      "<S-CR>",
      function()
        require("orgmode").action("org_mappings.meta_return")
      end,
      mode = "i",
      silent = true,
      buffer = true,
    },
    {
      "<leader>ofr",
      function()
        require("telescope").extensions.orgmode.refile_heading({})
      end,
      mode = "n",
    },
    {
      "<leader>ofh",
      function()
        require("telescope").extensions.orgmode.search_headings({})
      end,
      mode = "n",
    },
    {
      "<leader>off",
      function()
        require("telescope").extensions.orgmode.search_headings({
          mode = "orgfiles",
        })
      end,
      mode = "n",
    },
  },
}
