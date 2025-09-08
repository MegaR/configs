return {
    'rmagatti/auto-session',
    -- lazy = true,
    config = function()
        require('auto-session').setup {
            log_level = 'error',
            pre_save_cmds = { require('neo-tree.sources.manager').close_all },
            bypass_save_filetypes = { 'neo-tree', 'spectre' },
            auto_save = true,
            auto_restore = true,
            git_use_branch_name = true,
            cwd_change_handling = {
                post_cwd_changed_hook = function()
                    require('lualine').refresh()
                end,
            },
        }
    end,
}
