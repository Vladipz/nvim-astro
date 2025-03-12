function setup_c_sharp(dap)
  dap.adapters.netcoredbg = {
    type = "executable",
    command = "C:\\Users\\Vlad\\AppData\\Local\\nvim-astro-data\\mason\\packages\\netcoredbg\\netcoredbg\\netcoredbg.exe",
    args = { "--interpreter=vscode" },
  }
  dap.configurations.cs = {
    {
      type = "coreclr",
      name = ".NET - attach",
      request = "attach",
      console = "integratedTerminal",
      justMyCode = false,
      program = function() return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file") end,
      processId = function() return vim.fn.input "Process ID: " end,
    },
  }
end

function setup_xaml_support()
  -- Define path to Avalonia LSP binary
  local avalonia_lsp_bin =
    "C:\\Users\\Vlad\\.vscode\\extensions\\avaloniateam.vscode-avalonia-0.0.32\\avaloniaServer\\AvaloniaLanguageServer.dll" -- Update this path!

  -- Create autocommands for XAML files
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.xaml",
    callback = function()
      vim.opt_local.filetype = "xml"
      vim.opt_local.omnifunc = "xaml#complete"
    end,
  })

  -- Create autocommands for Avalonia AXAML files
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.xaml",
    callback = function()
      vim.cmd.setfiletype "xml"
      vim.lsp.start {
        name = "Avalonia LSP",
        cmd = { "dotnet", avalonia_lsp_bin },
        root_dir = vim.fn.getcwd(),
      }
    end,
  })
end

return {
  -- CSharp support
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "c_sharp" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "omnisharp" })
    end,
  },
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    dependencies = {
      {
        "AstroNvim/astrolsp",
        opts = {
          config = {
            omnisharp = {
              handlers = {
                ["textDocument/definition"] = function(...) require("omnisharp_extended").definition_handler(...) end,
                ["textDocument/typeDefinition"] = function(...)
                  require("omnisharp_extended").type_definition_handler(...)
                end,
                ["textDocument/references"] = function(...) require("omnisharp_extended").references_handler(...) end,
                ["textDocument/implementation"] = function(...)
                  require("omnisharp_extended").implementation_handler(...)
                end,
              },
            },
          },
        },
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "coreclr" })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = function(_, opts)
      local dap = require "dap"
      setup_c_sharp(dap)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "omnisharp", "netcoredbg" })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "Issafalcon/neotest-dotnet", config = function() end },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-dotnet"(require("astrocore").plugin_opts "neotest-dotnet"))
    end,
  },
  {
    "yuratomo/dotnet-complete",
  },
  -- Initialize the XAML support
  {
    "AstroNvim/astrocore",
    config = function(plugin, opts)
      require("astrocore").setup(opts)
      setup_xaml_support() -- Call it after plugin setup
    end,
  },
}
