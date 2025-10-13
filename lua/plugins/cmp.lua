return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet Engine
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    
    -- Autocompletion sources
    "saadparwaiz1/cmp_luasnip",     -- Snippet completions
    "hrsh7th/cmp-nvim-lsp",         -- LSP completions
    "hrsh7th/cmp-buffer",           -- Buffer completions
    "hrsh7th/cmp-path",             -- Path completions
    "hrsh7th/cmp-nvim-lua",         -- Neovim Lua API completions
    
    -- Snippet collection (optional)
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    
    -- Carica snippet da friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- Seleziona precedente
        ["<C-j>"] = cmp.mapping.select_next_item(), -- Seleziona successivo
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),     -- Mostra completamento
        ["<C-e>"] = cmp.mapping.abort(),            -- Chiudi
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Conferma selezione
        
        -- Tab per navigare snippet
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      
      -- Sources per autocompletamento (ordine = priorità)
      sources = cmp.config.sources({
        { name = "nvim_lsp" },   -- Da LSP
        { name = "luasnip" },    -- Da snippet
        { name = "buffer" },     -- Da buffer corrente
        { name = "path" },       -- Da filesystem
        { name = "nvim_lua" },   -- Da Neovim Lua API
      }),
      
      -- Formattazione voci completamento
      formatting = {
        format = function(entry, item)
          -- Mostra da quale source proviene
          item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
            nvim_lua = "[Lua]",
          })[entry.source.name]
          return item
        end,
      },
    })
  end,
}
