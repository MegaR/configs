return {
    'rebelot/kanagawa.nvim',
    dependencies = {
        'nvim-lualine/lualine.nvim',
        'levouh/tint.nvim',
    },
    config = function()
        require('kanagawa').setup {
            transparent = true,
            -- dimInactive = true,
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
        require('tint').setup {}
    end,
}
