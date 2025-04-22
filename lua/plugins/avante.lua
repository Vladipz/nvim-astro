-- return {
--   "yetone/avante.nvim",
--   opts = {
--     provider = "copilot",
--     auto_suggestions_provider = "copilot",
--     copilot = {
--       model = "claude-3.7-sonnet",
--     },
--   },
-- }
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Завжди використовувати останню версію
  opts = {
    provider = "copilot",
    copilot = {
      model = "claude-3.7-sonnet",
    },
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = false, -- Experimental stage
      auto_suggestions_respect_ignore = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      jump_result_buffer_on_finish = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
      enable_token_counting = true,
      enable_cursor_planning_mode = false,
      enable_claude_text_editor_tool_mode = false,
      use_cwd_as_project_root = true,
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
