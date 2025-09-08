return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        { 'yavorski/lualine-macro-recording.nvim' },
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
            lualine_x = { 'encoding', 'fileformat', 'lsp_status', 'filetype' },
        },
    },
}
