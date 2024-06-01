return {
    'nvim-pack/nvim-spectre',
    opts = {},
    config = function()
        vim.keymap.set('n', '<leader>S', require("spectre").toggle, {
            desc = 'Toggle Spectre',
        })
    end,
}
