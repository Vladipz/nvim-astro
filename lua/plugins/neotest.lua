return {
    "nvim-neotest/neotest",
    opts = {

    },
    keys = {
        { "<leader>tr", function() require("neotest").run.run() end,                     desc = "[T]est [R]un" },
        { "<leader>tR", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "[T]est [R]UN (all)" },
        { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "[T]est [O]utput" },
        {
            "<leader>te",
            function()
                local summary_window = require("neotest").summary
                summary_window.toggle()
                -- Задаємо розміри вікна
                -- local win = vim.api.nvim_get_current_win()
                -- vim.api.nvim_win_set_width(win, 40) -- ширина вікна
            end,
            desc = "[T]est [E]xplorer"
        },
        { "<leader>ts", function() require("neotest").output_panel.toggle() end,         desc = "[T]est [S]ummary" },
        { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "[T]est [D]ebug" },
    },

}
