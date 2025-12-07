return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'folke/snacks.nvim' },
    opts = {},
    keys = {
        {
            '<leader>st',
            function()
                ---@diagnostic disable-next-line: undefined-field
                Snacks.picker.todo_comments()
            end,
            desc = 'Todo',
        },
        {
            '<leader>sT',
            function()
                ---@diagnostic disable-next-line: undefined-field
                Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
            end,
            desc = 'Todo/Fix/Fixme',
        },
    },
}
