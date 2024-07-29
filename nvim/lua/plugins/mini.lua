return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        require('mini.splitjoin').setup {}
        require('mini.jump').setup {
            delay = {
                highlight = 1000000,
            }
        }
        require('mini.surround').setup {}
        require('mini.ai').setup {}
        require('mini.comment').setup {}
        require('mini.hipatterns').setup {}
        -- require('mini.icons').setup {}
        -- require('mini.animate').setup {
        --     open = { enable = false },
        --     resize = { enable = false },
        -- }
    end,
}
