return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_nvim_dap = require("mason-nvim-dap")

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Setup Mason
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    -- Setup Mason LSPConfig
    mason_lspconfig.setup({
      -- Questa lista è vuota perché per Rust usiamo rustaceanvim
      -- che gestisce rust-analyzer automaticamente
      -- Aggiunto TAPLO per la gestione del Cargo.toml ed i file TOML in generale
      ensure_installed = { "taplo" },
    })

    -- Setup Mason DAP - installa automaticamente codelldb
    mason_nvim_dap.setup({
      ensure_installed = { "codelldb" },
      automatic_installation = true,
    })

    vim.lsp.config("taplo", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        evenBetterToml = {
          schema = {
            enabled = true,
            associations = {
              ["Cargo\\.toml$"] = "https://json.schemastore.org/cargo.json",
            },
          },
        },
      },
    })

    -- Keymap per aprire Mason
    vim.keymap.set('n', '<leader>m', '<cmd>Mason<cr>', { desc = 'Open Mason' })
  end,
}
