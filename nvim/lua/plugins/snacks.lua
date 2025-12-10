return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        notifier = { enabled = false },
        quickfile = { enabled = true },
        statuscolumn = { enabled = false },
        words = { enabled = false },
        picker = {
            layout = 'telescope',

            win = {
                list = {
                    keys = {
                        ['/'] = 'toggle_focus',
                        ['<2-LeftMouse>'] = 'confirm',
                        ['<CR>'] = 'confirm',
                        ['<Down>'] = 'list_down',
                        ['<Esc>'] = 'cancel',
                        -- ["<S-CR>"] = { { "pick_win", "jump" } },
                        ['<S-Tab>'] = { 'select_and_prev', mode = { 'n', 'x' } },
                        ['<Tab>'] = { 'select_and_next', mode = { 'n', 'x' } },
                        ['<Up>'] = 'list_up',
                        ['<a-d>'] = 'inspect',
                        ['<a-f>'] = 'toggle_follow',
                        ['<a-h>'] = 'toggle_hidden',
                        ['<a-i>'] = 'toggle_ignored',
                        ['<a-m>'] = 'toggle_maximize',
                        ['<a-p>'] = 'toggle_preview',
                        ['<a-w>'] = 'cycle_win',
                        ['<c-a>'] = 'select_all',
                        ['<c-b>'] = 'preview_scroll_up',
                        ['<c-d>'] = 'list_scroll_down',
                        ['<c-f>'] = 'preview_scroll_down',
                        ['<c-j>'] = 'list_down',
                        ['<c-k>'] = 'list_up',
                        ['<c-n>'] = 'list_down',
                        ['<c-p>'] = 'list_up',
                        ['<c-q>'] = 'qflist',
                        ['<c-g>'] = 'print_path',
                        ['<c-s>'] = 'edit_split',
                        ['<c-t>'] = 'tab',
                        ['<c-u>'] = 'list_scroll_up',
                        ['<c-v>'] = 'edit_vsplit',
                        ['<c-w>H'] = 'layout_left',
                        ['<c-w>J'] = 'layout_bottom',
                        ['<c-w>K'] = 'layout_top',
                        ['<c-w>L'] = 'layout_right',
                        ['?'] = 'toggle_help_list',
                        ['G'] = 'list_bottom',
                        ['gg'] = 'list_top',
                        ['i'] = 'focus_input',
                        ['j'] = 'list_down',
                        ['k'] = 'list_up',
                        ['q'] = 'cancel',
                        ['zb'] = 'list_scroll_bottom',
                        ['zt'] = 'list_scroll_top',
                        ['zz'] = 'list_scroll_center',
                    },
                },
                input = {
                    keys = {
                        ['/'] = 'toggle_focus',
                        ['<C-Down>'] = { 'history_forward', mode = { 'i', 'n' } },
                        ['<C-Up>'] = { 'history_back', mode = { 'i', 'n' } },
                        ['<C-c>'] = { 'cancel', mode = 'i' },
                        ['<C-w>'] = { '<c-s-w>', mode = { 'i' }, expr = true, desc = 'delete word' },
                        ['<CR>'] = { 'confirm', mode = { 'n', 'i' } },
                        ['<Down>'] = { 'list_down', mode = { 'i', 'n' } },
                        ['<Esc>'] = 'cancel',
                        -- ['<S-CR>'] = { { 'pick_win', 'jump' }, mode = { 'n', 'i' } },
                        ['<S-Tab>'] = { 'select_and_prev', mode = { 'i', 'n' } },
                        ['<Tab>'] = { 'select_and_next', mode = { 'i', 'n' } },
                        ['<Up>'] = { 'list_up', mode = { 'i', 'n' } },
                        ['<a-d>'] = { 'inspect', mode = { 'n', 'i' } },
                        ['<a-f>'] = { 'toggle_follow', mode = { 'i', 'n' } },
                        ['<a-h>'] = { 'toggle_hidden', mode = { 'i', 'n' } },
                        ['<a-i>'] = { 'toggle_ignored', mode = { 'i', 'n' } },
                        ['<a-r>'] = { 'toggle_regex', mode = { 'i', 'n' } },
                        ['<a-m>'] = { 'toggle_maximize', mode = { 'i', 'n' } },
                        ['<a-p>'] = { 'toggle_preview', mode = { 'i', 'n' } },
                        ['<a-w>'] = { 'cycle_win', mode = { 'i', 'n' } },
                        ['<c-a>'] = { 'select_all', mode = { 'n', 'i' } },
                        ['<c-b>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
                        ['<c-d>'] = { 'list_scroll_down', mode = { 'i', 'n' } },
                        ['<c-f>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
                        ['<c-g>'] = { 'toggle_live', mode = { 'i', 'n' } },
                        ['<c-j>'] = { 'list_down', mode = { 'i', 'n' } },
                        ['<c-k>'] = { 'list_up', mode = { 'i', 'n' } },
                        ['<c-n>'] = { 'list_down', mode = { 'i', 'n' } },
                        ['<c-p>'] = { 'list_up', mode = { 'i', 'n' } },
                        ['<c-q>'] = { 'qflist', mode = { 'i', 'n' } },
                        ['<c-s>'] = { 'edit_split', mode = { 'i', 'n' } },
                        ['<c-t>'] = { 'tab', mode = { 'n', 'i' } },
                        ['<c-u>'] = { 'list_scroll_up', mode = { 'i', 'n' } },
                        ['<c-v>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
                        ['<c-r>#'] = { 'insert_alt', mode = 'i' },
                        ['<c-r>%'] = { 'insert_filename', mode = 'i' },
                        ['<c-r><c-a>'] = { 'insert_cWORD', mode = 'i' },
                        ['<c-r><c-f>'] = { 'insert_file', mode = 'i' },
                        ['<c-r><c-l>'] = { 'insert_line', mode = 'i' },
                        ['<c-r><c-p>'] = { 'insert_file_full', mode = 'i' },
                        ['<c-r><c-w>'] = { 'insert_cword', mode = 'i' },
                        ['<c-w>H'] = 'layout_left',
                        ['<c-w>J'] = 'layout_bottom',
                        ['<c-w>K'] = 'layout_top',
                        ['<c-w>L'] = 'layout_right',
                        ['?'] = 'toggle_help_input',
                        ['G'] = 'list_bottom',
                        ['gg'] = 'list_top',
                        ['j'] = 'list_down',
                        ['k'] = 'list_up',
                        ['q'] = 'cancel',
                    },
                },
            },
        },
    },
    keys = {
        -- lazy git
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
        -- picker
        {
            '<leader>gf',
            function()
                Snacks.picker.git_files()
            end,
            desc = 'Search Git Files',
        },
        {
            '<leader>sf',
            function()
                Snacks.picker.smart()
            end,
            desc = 'Search Files',
        },
        {
            '<leader>sg',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Search Grep',
        },
        {
            '<leader>sw',
            function()
                Snacks.picker.grep_word()
            end,
            desc = 'Search current word',
        },
        {
            '<leader>sh',
            function()
                Snacks.picker.help()
            end,
            desc = 'Search Help',
        },
        {
            '<leader>sk',
            function()
                Snacks.picker.keymaps()
            end,
            desc = 'Search Keymaps',
        },
        {
            '<leader>sd',
            function()
                Snacks.picker.diagnostics()
            end,
            desc = 'Diagnostics',
        },
        {
            '<leader>ss',
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = 'LSP Symbols',
        },
        {
            '<leader>sS',
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = 'LSP Workspace Symbols',
        },
        {
            '<leader>?',
            function()
                Snacks.picker.lines()
            end,
            desc = 'Buffers',
        },
        {
            '<leader><space>',
            function()
                Snacks.picker.buffers()
            end,
            desc = 'Buffers',
        },
        {
            'gd',
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = 'Goto Definition',
        },
        {
            'gD',
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = 'Goto Declaration',
        },
        {
            'gr',
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = 'References',
        },
        {
            'gI',
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = 'Goto Implementation',
        },
        {
            'gy',
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = 'Goto T[y]pe Definition',
        },
    },
}
