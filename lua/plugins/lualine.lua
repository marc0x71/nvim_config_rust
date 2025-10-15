return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "gruvbox-material",
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        globalstatus = true,  -- Una statusline per tutte le finestre
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 
          {
            'filename',
            path = 1,  -- 0 = solo nome, 1 = relativo, 2 = assoluto
          }
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
          },
          'encoding',
          'fileformat',
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'fugitive', 'oil', 'trouble' },
    })
  end,
}

