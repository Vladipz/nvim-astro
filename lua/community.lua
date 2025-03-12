-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.pack.cs-omnisharp" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.recipes.telescope-lsp-mappings" },
  { import = "astrocommunity.pack.angular" },
  { import = "astrocommunity.docker.lazydocker" },
  -- { import = "astrocommunity.editing-support.copilotchat-nvim" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.scrolling.neoscroll-nvim" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.xml" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.file-explorer.oil-nvim" },
  { import = "astrocommunity.game.leetcode-nvim" },
  { import = "astrocommunity.completion.avante-nvim" },
}
