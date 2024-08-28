return {
    'Shatur/neovim-ayu',
    dependencies = {
        'nvim-lualine/lualine.nvim',
        'levouh/tint.nvim',
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
        require('tint').setup {}
    end,
}
