-- Useful plugin to show you pending keybinds.
return {
    'folke/which-key.nvim',
    opts = {},
    config = function()
        local wk = require 'which-key'
        wk.add {
            { '<leader>g', group = 'Git' },
            { '<leader>c', group = 'Code' },
            { '<leader>s', group = 'Search' },
            { '<leader>w', group = 'Workspace' },
            { '<leader>p', group = 'Package' },
            { '<leader>h', group = 'Harpoon' },
            { '<leader>d', group = 'Fun' },
            { 'gq', desc = 'Format motion' },
        }
    end,
}
