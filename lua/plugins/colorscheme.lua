return {
  "sainnhe/gruvbox-material",
  lazy = false,     -- Carica immediatamente
  priority = 1000,  -- Carica prima di altri plugin
  config = function()
    -- Configura il colorscheme
    vim.g.gruvbox_material_background = 'medium'  -- 'soft', 'medium', 'hard'
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_enable_italic = 1
    
    -- Applica il colorscheme
    vim.cmd.colorscheme('gruvbox-material')
  end,
}
