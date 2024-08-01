return {
    'nvim-pack/nvim-spectre',
    opts = {},
    config = function()
        require('spectre').setup({
            use_trouble_qf = true,
        })
        vim.keymap.set('n', '<leader>S', require("spectre").toggle, {
            desc = 'Toggle Spectre',
        })
    end,
}
