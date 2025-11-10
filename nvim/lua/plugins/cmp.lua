---@diagnostic disable: unused-local
return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
        -- show function parameters while typing
        'hrsh7th/cmp-nvim-lsp-signature-help',

        -- Snippet Engine & its associated nvim-cmp source
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',

        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',

        -- Adds a number of user-friendly snippets
        'rafamadriz/friendly-snippets',

        -- adds symbols
        'onsails/lspkind.nvim',
    },
    config = function()
        -- [[ Configure nvim-cmp ]]
        -- See `:help cmp`
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        local lspkind = require 'lspkind'
        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup {}

        ---@diagnostic disable-next-line: missing-fields
        cmp.setup {
            preselect = cmp.PreselectMode.Item,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-y>'] = cmp.mapping.confirm { select = true },
                ['<C-e>'] = cmp.mapping.abort(),
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
            },
            sources = {
                { name = 'lazydev', group_index = 0 },
                { name = 'nvim_lsp_signature_help' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
            },
            ---@diagnostic disable-next-line: missing-fields
            formatting = {
                format = lspkind.cmp_format {
                    mode = 'symbol',
                    maxwidth = 50,
                    elipsis_char = '…',
                    symbol_map = {
                        Text = '󰉿',
                        Method = '󰆧',
                        Function = '󰊕',
                        Constructor = '',
                        Field = '󰜢',
                        Variable = '󰀫',
                        Class = '󰠱',
                        Interface = '',
                        Module = '',
                        Property = '󰜢',
                        Unit = '󰑭',
                        Value = '󰎠',
                        Enum = '',
                        Keyword = '󰌋',
                        Snippet = '',
                        Color = '󰏘',
                        File = '󰈙',
                        Reference = '󰈇',
                        Folder = '󰉋',
                        EnumMember = '',
                        Constant = '󰏿',
                        Struct = '󰙅',
                        Event = '',
                        Operator = '󰆕',
                        TypeParameter = '',
                    },
                },
            },
        }
    end,
}
