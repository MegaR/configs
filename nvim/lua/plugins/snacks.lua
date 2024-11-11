return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        styles = {},
        bigfile = { enabled = true },
        notifier = { enabled = false },
        quickfile = { enabled = true },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
    keys = {
        {
            '<leader>lg',
            function()
                Snacks.lazygit()
            end,
            desc = 'Lazygit',
        },
        {
            '<leader>ll',
            function()
                Snacks.lazygit.log()
            end,
            desc = 'Git logs',
        },
        {
            '<leader>lf',
            function()
                Snacks.lazygit.log_file()
            end,
            desc = 'Git logs file',
        },
        {
            '<leader>gB',
            function()
                Snacks.gitbrowse()
            end,
            desc = 'Git Browse',
        },
    },
}
