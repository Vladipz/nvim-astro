-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local vim = vim
-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local function set_mappings(client, buffer)
  -- NOTE: might remvoe this keymap later
  vim.keymap.set(
    "n",
    "<leader>oht",
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    { desc = "[O]ther: Inlay [H]ints [T]oggle" }
  )
  vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "[D]iagnostic [k] - previous", buffer = buffer })
  vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "[D]iagnostic [j] - next", buffer = buffer })
  vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "[D]iagnostic [O]pen", buffer = buffer })
  vim.keymap.set(
    { "n", "v" },
    "<leader>ca",
    vim.lsp.buf.code_action,
    { desc = "[R]e[F]actor (code action)", buffer = buffer }
  )
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition", buffer = buffer })
  vim.keymap.set(
    "n",
    "<leader>gtd",
    vim.lsp.buf.type_definition,
    { desc = "[G]o to [T]ype [D]efinition", buffer = buffer }
  )
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "K - show info, help", buffer = buffer })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame", buffer = buffer })
  if client.server_capabilities.signatureHelpProvider then
    require("lsp-overloads").setup(client, {
      display_automatically = true,
      ui = {
        border = { " ", "", " ", " ", " ", "", " ", " " },
      },
    })
    vim.keymap.set(
      { "n", "i" },
      "<C-n>",
      "<cmd>LspOverloadsSignature<CR>",
      { desc = "Ctrl + n - show signature help with overloads (if they are present)", buffer = buffer }
    )
  else
    vim.keymap.set(
      { "n", "i" },
      "<C-n>",
      vim.lsp.buf.signature_help,
      { desc = "Ctrl + n - show signature help", buffer = buffer }
    )
  end
end
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      omnisharp = {
        settings = {

          FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
          },
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        ["<Leader>ca"] = {
          function() vim.lsp.buf.code_action() end,
          desc = "Code actions",
          cond = "textDocument/codeAction",
        },
        ["<Leader>rn"] = {
          function() vim.lsp.buf.rename() end,
          desc = "Rename symbol",
          cond = "textDocument/rename",
        },
        ["<Leader>fm"] = {
          function() vim.lsp.buf.format() end,
          desc = "Format document",
          cond = "textDocument/formatting",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },

        -- ["<Leader>gd"] = {
        --     function() require("telescope.builtin").lsp_definitions() end,
        --     desc = "[G]o to [D]efinitions",
        -- },
        -- diagnostic on cursor hold
        ["<Leader>do"] = {
          function() vim.diagnostic.open_float() end,
          desc = "[D]iagnostic [O]pen",
        },
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
        gi = {
          function() require("telescope.builtin").lsp_implementations() end,
          desc = "[G]o to [I]mplementations",
          cond = "textDocument/implementation",
        },
        gr = {
          function() require("telescope.builtin").lsp_references() end,
          desc = "[G]o to [R]eferences",
          cond = "textDocument/references",
        },

        -- disable
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr) set_mappings(client, bufnr) end,
  },
}
