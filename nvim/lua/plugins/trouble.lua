return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/snacks.nvim' },
    opts = function(_, opts)
        return vim.tbl_deep_extend('force', opts or {}, {
            picker = {
                actions = require('trouble.sources.snacks').actions,
                win = {
                    input = {
                        keys = {
                            ['<c-t>'] = {
                                'trouble_open',
                                mode = { 'n', 'i' },
                            },
                        },
                    },
                },
            },
        })
    end,
    config = function()
        local trouble = require 'trouble'
        vim.keymap.set('n', '<leader>q', function()
            trouble.toggle 'diagnostics'
        end, { desc = 'Toggle diagnostics list' })
        vim.keymap.set('n', '<leader>xq', function()
            trouble.toggle 'quicklist'
        end, { desc = 'Toggle quicklist' })
    end,
}
