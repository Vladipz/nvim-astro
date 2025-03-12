return {
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function() vim.opt.completeopt = vim.opt.completeopt + "noinsert" + "noselect" end,
      })
      vim.api.nvim_create_autocmd("BufLeave", {
        pattern = "copilot-*",
        callback = function() vim.opt.completeopt = vim.opt.completeopt - "noinsert" - "noselect" end,
      })
      -- Оновлений конфіг з маппінгами
      opts.mappings = {
        complete = {
          --TODO: change to a better keymap
          insert = "1",
        },
      }

      -- Перезаписуємо нові налаштування в конфіг плагіна
      require("CopilotChat").setup(opts)
    end,
  },
}
