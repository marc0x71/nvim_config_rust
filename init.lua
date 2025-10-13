-- init.lua
-- Configurazione base di Neovim

-- Opzioni generali
vim.g.mapleader = " "  -- Space come leader key
vim.g.maplocalleader = " "

-- Impostazioni UI
vim.opt.number = true          -- Numeri di riga
vim.opt.relativenumber = true  -- Numeri relativi
vim.opt.mouse = 'a'            -- Abilita mouse
vim.opt.ignorecase = true      -- Ignora case nella ricerca
vim.opt.smartcase = true       -- Case-sensitive se maiuscole presenti
vim.opt.hlsearch = false       -- Non evidenziare ricerche
vim.opt.wrap = false           -- Non wrappare le righe
vim.opt.breakindent = true     -- Mantieni indentazione quando wrapped
vim.opt.tabstop = 4            -- Tab = 4 spazi
vim.opt.shiftwidth = 4         -- Indentazione = 4 spazi
vim.opt.expandtab = true       -- Usa spazi invece di tab
vim.opt.termguicolors = true   -- Abilita colori 24-bit

-- Clipboard di sistema
vim.opt.clipboard = 'unnamedplus'

-- Salvataggio automatico undo
vim.opt.undofile = true

-- Tempo di aggiornamento ridotto
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim con i plugin
require("lazy").setup({
  -- Importa tutti i file dalla directory plugins
  { import = "plugins" },
}, {
  checker = {
    enabled = true,  -- Controlla automaticamente aggiornamenti
    notify = false,  -- Non notificare
  },
  change_detection = {
    notify = false,  -- Non notificare cambiamenti config
  },
})

-- Toggle diagnostics
local diagnostics_active = true
local toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.api.nvim_echo({ { "Show diagnostics" } }, false, {})
    vim.diagnostic.enable()
  else
    vim.api.nvim_echo({ { "Disable diagnostics" } }, false, {})
    vim.diagnostic.enable(false)
  end
end

local function open_terminal(command)
  command = command or os.getenv("SHELL")
  if os.getenv("TMUX") then
    if os.getenv("POETRY_ACTIVE") then
      command = "poetry run " .. command
    end
    --  TMUX session active
    print("silent !tmux split-window -l 10 " .. command .. "<cr>")
    vim.cmd("silent !tmux split-window -l 10 " .. command)
  else
    vim.cmd.vnew()
    vim.cmd.term(command)
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
  end
end

-- Keymaps generali
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Quit' })
vim.keymap.set("n", "<M-n>", "<cmd>bnext<CR>", {})
vim.keymap.set("n", "<M-p>", "<cmd>bprev<CR>", {})
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {})

vim.keymap.set("n", "<leader>tt", function()
  open_terminal()
end, { desc = "[T]erminal " })


-- Keymaps per diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error' })
vim.keymap.set("n", "<leader>xi", toggle_diagnostics, { desc = "Toggle [i]nline diagnostic" })
vim.keymap.set("n", "<leader>xq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })



