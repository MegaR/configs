return {
    'rebelot/kanagawa.nvim',
    dependencies = {
        'nvim-lualine/lualine.nvim',
    },
    config = function()
        require('kanagawa').setup {
            transparent = true,
            dimInactive = false,
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = 'none',
                        },
                    },
                },
            },
        }
        vim.cmd 'colorscheme kanagawa'
    end,
}
