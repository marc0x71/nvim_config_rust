return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = { "rust" },  -- Carica solo per file Rust
  config = function()
    vim.g.rustaceanvim = {
      -- LSP settings
      server = {
        on_attach = function(client, bufnr)
          -- Keymaps per LSP
          local opts = { buffer = bufnr, noremap = true, silent = true }
          
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
          
          -- Rustacean specific
          vim.keymap.set('n', '<leader>rd', '<cmd>RustLsp debuggables<cr>', opts)
          vim.keymap.set('n', '<leader>rr', '<cmd>RustLsp runnables<cr>', opts)
          vim.keymap.set('n', '<leader>rt', '<cmd>RustLsp testables<cr>', opts)
          vim.keymap.set('n', '<leader>re', '<cmd>RustLsp expandMacro<cr>', opts)
        end,
        
        default_settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Usa 'check' invece di 'checkOnSave'
            check = {
              command = "clippy",  -- Usa clippy invece di check
            },
            procMacro = {
              enable = true,
            },
            diagnostics = {
              enable = true,
              experimental = {
                enable = true,
              },
            },
          },
        },
      },
      
      -- DAP (Debug Adapter Protocol)
      dap = {
        adapter = {
          type = "server",
          port = "${port}",
          executable = {
            command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            args = { "--port", "${port}" },
          },
        },
      },
    }
  end,
  dependencies = {
    -- Plugin per debugging
    {
      "mfussenegger/nvim-dap",
      config = function()
        local dap = require("dap")
        
        -- Keymaps per debugging
        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      end,
    },
    
    -- UI per il debugger
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      config = function()
        local dap, dapui = require("dap"), require("dapui")
        
        dapui.setup()
        
        -- Apri/chiudi automaticamente UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
        
        vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })
      end,
    },
  },
}
