return {
  -- "AstroNvim/astrocore",
  -- ---@type AstroCoreOpts
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    mappings = {
      n = {
        -- ["<C-p>"] = { function() require("telescope.builtin").find_files() end, desc = "[F]ind [F]iles" },
        -- ["<leader><leader>"] = {
        --   function() require("telescope.builtin").buffers() end,
        --   desc = "Space + Space - find buffers for quick access",
        -- },
        ["<leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "[F]ind [F]iles" },
        ["<leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "[F]ind [B]uffers" },
        ["<leader>fw"] = {
          function() require("telescope.builtin").grep_string() end,
          desc = "[F]ind [W]ord (under cursor)",
        },
        ["<leader>fc"] = { function() require("telescope.builtin").live_grep() end, desc = "[F]ind [C]ontents" },
        ["<leader>fg"] = { function() require("telescope.builtin").git_files() end, desc = "[F]ind in [G]it" },
        ["<leader>da"] = { function() require("telescope.builtin").diagnostics() end, desc = "[D]iagnostics [A]ll" },
        ["<leader>gi"] = {
          function() require("telescope.builtin").lsp_implementations() end,
          desc = "[G]o to [I]mplementations",
        },
        ["<leader>gr"] = { function() require("telescope.builtin").lsp_references() end, desc = "[G]o to [R]eferences" },
        ["<leader>cs"] = { function() require("telescope.builtin").colorscheme() end, desc = "[C]olor[S]cheme" },
        ["<leader>fW"] = {
          function() require("telescope.builtin").grep_string { search = vim.fn.expand "<cWORD>" } end,
          desc = "[F]ind [W]ord (under cursor)",
        },
      },
    }
    -- opts.defaults = {
    --   layout_strategy = "horizontal", -- Вибираємо горизонтальну стратегію
    --   layout_config = {
    --     width = 0.95, -- Встановлюємо ширину вікна (95% від ширини екрану)
    --     height = 0.9, -- Встановлюємо висоту вікна (90% від висоти екрану)
    --     prompt_position = "top", -- Запит (query) нагорі
    --     preview_width = 0.5, -- Ширина прев'ю панелі (50% від ширини)
    --   },
    --   sorting_strategy = "ascending", -- Сортуємо результати "згори вниз"
    --   prompt_prefix = "🔍 ", -- Префікс для вашого запиту
    --   selection_caret = "➤ ", -- Індикатор виділення
    -- }
  end,
}
