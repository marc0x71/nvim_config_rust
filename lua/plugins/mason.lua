return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_nvim_dap = require("mason-nvim-dap")
    
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
      ensure_installed = {},
    })
    
    -- Setup Mason DAP - installa automaticamente codelldb
    mason_nvim_dap.setup({
      ensure_installed = { "codelldb" },
      automatic_installation = true,
    })
    
    -- Keymap per aprire Mason
    vim.keymap.set('n', '<leader>m', '<cmd>Mason<cr>', { desc = 'Open Mason' })
  end,
}
