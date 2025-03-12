-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
    xaml = "xml",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}
