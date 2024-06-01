return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        require('mini.splitjoin').setup {}
        require('mini.jump').setup {}
        require('mini.surround').setup {}
        require('mini.ai').setup {}
        require('mini.comment').setup {}
        require('mini.animate').setup {
            open = { enable = false }
        }
    end,
}
