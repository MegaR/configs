return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local oil = require 'oil'
        oil.setup {
            view_options = {
                show_hidden = true,
            },
            win_options = {
                signcolumn = 'yes:2',
            },
        }
        vim.keymap.set('n', '<leader>o', oil.open, { desc = 'Oil' })
    end,
}
