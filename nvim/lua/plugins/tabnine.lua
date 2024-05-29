return {
    'codota/tabnine-nvim',
    build = './dl_binaries.sh',
    config = function()
        require('tabnine').setup {
            disable_auto_comment = true,
            accept_keymap = '<C-j>',
            dismiss_keymap = '<C-e>',
            debounce_ms = 800,
            exclude_filetypes = { 'TelescopePrompt', 'neo-tree' },
            log_file_path = nil,
        }
    end,
}
