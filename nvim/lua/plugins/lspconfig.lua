-- NOTE: This is where your plugins related to LSP can be installed.
--  The configuration is done below. Search for lspconfig to find it below.
return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', opts = {} },

        -- DAP
        'jay-babu/mason-nvim-dap.nvim',
        'williamboman/mason.nvim',
        'mfussenegger/nvim-dap',
    },
    config = function()
        local lspconfig = vim.lsp.config

        -- [[ Configure LSP ]]
        --  This function gets run when an LSP connects to a particular buffer.
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end

                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end

                nmap('<leader>cr', vim.lsp.buf.rename, '[R]ename')
                nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                -- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
                -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
                -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
                -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                -- See `:help K` for why this keymap
                nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

                -- Lesser used LSP functionality
                nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                nmap('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, '[W]orkspace [L]ist Folders')

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end
                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    nmap('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local servers = {
            html = { filetypes = { 'html', 'twig', 'hbs' } },
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
            -- ts_ls = {
            --     plugins = {
            --     },
            --     filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
            --     settings = {
            --         javascript = {
            --             inlayHints = {
            --                 includeInlayEnumMemberValueHints = true,
            --                 includeInlayFunctionLikeReturnTypeHints = true,
            --                 includeInlayFunctionParameterTypeHints = true,
            --                 includeInlayParameterNameHints = 'all',
            --                 includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            --                 includeInlayPropertyDeclarationTypeHints = true,
            --                 includeInlayVariableTypeHints = true,
            --             },
            --         },
            --         typescript = {
            --             inlayHints = {
            --                 includeInlayEnumMemberValueHints = true,
            --                 includeInlayFunctionLikeReturnTypeHints = true,
            --                 includeInlayFunctionParameterTypeHints = true,
            --                 includeInlayParameterNameHints = 'all',
            --                 includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            --                 includeInlayPropertyDeclarationTypeHints = true,
            --                 includeInlayVariableTypeHints = true,
            --             },
            --         },
            --     },
            -- },
            docker_compose_language_service = {},
            dockerls = {},
            bashls = {},
            cssls = {},
            css_variables = {},
            jsonls = {},
            sqlls = {},
            yamlls = {
                schemas = {
                    kubernetes = '*.yaml',
                    ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
                    ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
                    ['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
                    ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
                    ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
                    ['http://json.schemastore.org/ansible-playbook'] = '*play*.{yml,yaml}',
                    ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
                    ['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
                    ['https://json.schemastore.org/gitlab-ci'] = '*gitlab-ci*.{yml,yaml}',
                    ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] = '*api*.{yml,yaml}',
                    ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
                    ['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
                },
            },
            -- phpactor = {},
            intelephense = {
                indent = {
                    enable = true,
                },
            },
            tailwindcss = {},
        }

        require('mason').setup()

        -- DAP
        require('mason-nvim-dap').setup {
            automatic_setup = {},
            ensure_installed = { 'php' },
            automatic_installation = true,
            handlers = {
                function(config)
                    require('mason-nvim-dap').default_setup(config)
                end,
                php = function(config)
                    config.configurations = {
                        {
                            type = 'php',
                            request = 'launch',
                            name = 'Listen for XDebug',
                            port = 9003,
                            log = true,
                            pathMappings = {
                                ['/var/www/html'] = vim.fn.getcwd() .. '/src',
                            },
                            hostname = '0.0.0.0',
                        },
                    }

                    require('mason-nvim-dap').default_setup(config) -- don't forget this!
                end,
            },
        }
        vim.keymap.set('n', '<Leader>dc', function()
            require('dap').continue()
        end, { desc = 'Continue' })
        vim.keymap.set('n', '<Leader>dj', function()
            require('dap').step_over()
        end, { desc = 'Step over' })
        vim.keymap.set('n', '<Leader>dl', function()
            require('dap').step_into()
        end, { desc = 'Step into' })
        vim.keymap.set('n', '<Leader>dh', function()
            require('dap').step_out()
        end, { desc = 'Step out' })
        vim.keymap.set('n', '<Leader>db', function()
            require('dap').toggle_breakpoint()
        end, { desc = 'Toggle breakpoint' })
        vim.keymap.set('n', '<Leader>dL', function()
            require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
        end, { desc = 'Log point' })
        vim.keymap.set('n', '<Leader>dr', function()
            require('dap').repl.open()
        end, { desc = 'Repl' })
        -- vim.keymap.set('n', '<Leader>dl', function()
        --     require('dap').run_last()
        -- end, {desc = 'Run last'})
        vim.keymap.set({ 'n', 'v' }, '<Leader>dH', function()
            require('dap.ui.widgets').hover()
        end, { desc = 'Hover' })
        vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
            require('dap.ui.widgets').preview()
        end, { desc = 'Preview' })
        vim.keymap.set('n', '<Leader>df', function()
            local widgets = require 'dap.ui.widgets'
            widgets.centered_float(widgets.frames)
        end, { desc = 'Frames' })
        vim.keymap.set('n', '<Leader>ds', function()
            local widgets = require 'dap.ui.widgets'
            widgets.centered_float(widgets.scopes)
        end, { desc = 'Scopes' })
        -- vim.keymap.set('n', '<Leader>dt', function()
        --     require('telescope').extensions.dap.commands {}
        -- end, { desc = 'Scopes' })

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
            'eslint_d',
            'luacheck',
            'markdownlint',
            'prettier',
            'stylua',
            'pint',
            'php-debug-adapter',
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {

            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}

                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    lspconfig[server_name].setup(server)
                end,
            },
        }
    end,
}
