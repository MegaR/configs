return {
  'yelog/i18n.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    -- optional pickers:
    -- 'ibhagwan/fzf-lua',
    -- 'nvim-telescope/telescope.nvim',
	'folke/snacks.nvim',
  },
  config = function()
    require('i18n').setup({
      activation = 'auto',
      locales = { 'nl', 'en' },
      sources = { 'src/resources/lang/{locales}.json', 'src/languages/{locales}.json' },
      func_pattern = {'t', '$t', 'trans'},
      func_type = {'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'tsx', 'jsx', 'php'},
      show_locale_file_eol_usage = false,
    })
  end
}
