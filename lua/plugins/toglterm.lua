return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = function(_, opts)
    opts.float_opts = {
      width = function()
        return math.floor(vim.o.columns * 0.95) -- 80% of screen width
      end,
      height = function()
        return math.floor(vim.o.lines * 0.96) -- 80% of screen height
      end,
      -- other options...
    }
  end,
}
