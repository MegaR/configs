return {
    'nvim-pack/nvim-spectre',
    opts = {},
    config = function()
        require('spectre').setup {
            use_trouble_qf = true,
            replace_engine = {
                ['sed'] = {
                    cmd = 'sed',
                    args = {
                        '-i',
                        '',
                        '-E',
                    },
                },
            },
        }
        vim.keymap.set('n', '<leader>S', require('spectre').toggle, {
            desc = 'Toggle Spectre',
        })
    end,
}
