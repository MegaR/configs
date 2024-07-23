return {
    'f-person/auto-dark-mode.nvim',
    dependencies = {
        'Shatur/neovim-ayu',
    },
    config = function()
        require('ayu').setup {
            mirage = true,
            overrides = {
                Normal = { bg = 'None' },
                ColorColumn = { bg = 'None' },
                SignColumn = { bg = 'None' },
                Folded = { bg = 'None' },
                FoldColumn = { bg = 'None' },
                CursorLine = { bg = 'None' },
                CursorColumn = { bg = 'None' },
                WhichKeyFloat = { bg = 'None' },
                VertSplit = { bg = 'None' },
            },
        }

        vim.cmd 'colorscheme ayu-mirage'
        local auto_dark_mode = require('auto-dark-mode')
        auto_dark_mode.setup {
            update_interval = 1000,
            set_dark_mode = function()
                vim.cmd 'colorscheme ayu-mirage'
            end,
            set_light_mode = function()
                vim.cmd 'colorscheme ayu-light'
            end,
        }
    end,
}
