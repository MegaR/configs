return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        { 'yavorski/lualine-macro-recording.nvim' },
        { 'yavorski/lualine-lsp-client-name.nvim' },
    },
    opts = {
        options = {
            icons_enabled = true,
            -- component_separators = '|',
            component_separators = '',
            section_separators = '',
            theme = 'kanagawa',
        },
        extensions = {
            'oil',
        },
        sections = {
            lualine_c = { 'filename', 'macro_recording', '%S' },
            lualine_x = { 'lsp_client_name', 'encoding', 'fileformat', 'filetype' },
        },
    },
}
