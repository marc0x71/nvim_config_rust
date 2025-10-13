return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")
    
    wk.setup({
      preset = "modern",
      win = {
        border = "rounded",
      },
    })
    
    -- Registra gruppi di keybindings
    wk.add({
      { "<leader>f", group = "find" },
      { "<leader>r", group = "rust" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "hunk" },
      { "<leader>d", group = "debug" },
      { "<leader>x", group = "diagnostics" },
    })
  end,
}
