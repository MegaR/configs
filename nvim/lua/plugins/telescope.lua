return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            -- DAP
            'nvim-telescope/telescope-dap.nvim',
        },
        config = function()
            local open_with_trouble = require('trouble.sources.telescope').open
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = { 'node%_modules/.*' },
                    pickers = {},
                    mappings = {
                        i = {
                            ['<c-t>'] = open_with_trouble,
                        },
                        n = {
                            ['<c-t>'] = open_with_trouble,
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        auto_depth = true,
                    },
                },
            }

            pcall(require('telescope').load_extension, 'fzf')
            require('telescope').load_extension('dap')

            -- See `:help telescope.builtin`
            vim.keymap.set('n', '<leader>?', function()
                require('telescope.builtin').oldfiles { only_cwd = true }
            end, { desc = '[?] Find recently opened files' })

            vim.keymap.set('n', '<leader><space>', function()
                require('telescope.builtin').buffers { sort_lastused = true }
            end, { desc = '[ ] Find existing buffers' })

            vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
            vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
            vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_document_symbols, { desc = '[S]earch [S]ymbols' })
        end,
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            pcall(require('telescope').load_extension 'file_browser')
        end,
    },
}
