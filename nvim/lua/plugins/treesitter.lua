return {
  -- Treesitter parsers + queries for Neovim 0.12
  'neovim-treesitter/nvim-treesitter',
  dependencies = {
    'neovim-treesitter/treesitter-parser-registry',
    'OXY2DEV/markview.nvim',

    -- Keep only if you actively use textobjects and have migrated it too
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
    },
  },
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')

    -- Install parsers
    ts.install({
      'c',
      'cpp',
      'go',
      'lua',
      'python',
      'rust',
      'yaml',
      'tsx',
      'typescript',
      'vue',
      'vimdoc',
      'vim',
      'php',
      'regex',
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'c',
        'cpp',
        'go',
        'lua',
        'python',
        'rust',
        'yaml',
        'typescript',
        'typescriptreact',
        'javascript',
        'javascriptreact',
        'tsx',
        'vue',
        'vim',
        'php',
        'markdown',
      },
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
