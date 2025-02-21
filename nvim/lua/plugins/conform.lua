return {
    'stevearc/conform.nvim',
    config = function()
        require('conform').setup {
            formatters_by_ft = {
                lua = { 'stylua' },
                -- Conform will run multiple formatters sequentially
                python = { 'isort', 'black' },
                -- Use a sub-list to run only the first available formatter
                javascript = { 'prettier' },
                javascriptreact = { 'prettier' },
                typescript = { 'prettier' },
                typescriptreact = { 'prettier' },
                php = { 'pint' },
            },
        }

        vim.keymap.set('', '<leader>f', function()
            require('conform').format { async = true, lsp_fallback = 'fallback' }
        end, { desc = '[F]ormat buffer' })

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_create_user_command('Format', function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = { start = { args.line1, 0 }, ['end'] = { args.line2, end_line:len() } }
            end
            require('conform').format { async = true, lsp_fallback = 'fallback', range = range }
        end, { desc = 'Format current buffer with LSP' })

        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = '*.php',
            callback = function(args)
                require('conform').format { bufnr = args.buf }
            end,
        })
    end,
}
