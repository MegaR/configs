return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'folke/snacks.nvim' },
    opts = {
        keywords = {
            FIX = { icon = ' ', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', '\\!' } },
            TODO = { icon = ' ', color = 'info', alt = { '\\*' } },
            HACK = { icon = ' ', color = 'warning' },
            WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
            PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
            NOTE = { icon = ' ', color = 'hint', alt = { 'INFO', '\\?' } },
            TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
        },
        highlight = {
            pattern = [[.*<(KEYWORDS):?\s*]],
        },
        search = {
            pattern = [[\b(KEYWORDS)\b]],
        },
    },
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

-- TODO test
-- FIX test
-- HACK test
-- WARN test
-- test TODO dkfjdf
-- INFO test
-- TODOtest
-- * test
-- ? test
-- ! test
-- AA test
