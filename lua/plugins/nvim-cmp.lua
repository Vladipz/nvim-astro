return {
  "hrsh7th/nvim-cmp",
  opts = {
    completion = {
      completeopt = "noinsert,popup",
    },
    mapping = {
      ["<C-f>"] = require("cmp").mapping.complete {},
    },
  },
}
