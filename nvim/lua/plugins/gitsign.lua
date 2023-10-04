return {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	'lewis6991/gitsigns.nvim',
	opts = {
		-- See `:help gitsigns.txt`
		signs = {
			add = { text = '▎' },
			change = { text = '▎' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '▎' },
		},
		on_attach = function(bufnr)
			local wk = require('which-key')

			wk.register({
				g = {
					name = "Git",
				},
			}, { prefix = "<leader>" })

			vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
				{ buffer = bufnr, desc = '[P]revious Hunk' })
			vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
				{ buffer = bufnr, desc = '[N]ext Hunk' })
			vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk,
				{ buffer = bufnr, desc = '[P]review Hunk' })
			vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk,
				{ buffer = bufnr, desc = '[R]eset Hunk' })
			vim.keymap.set('n', '<leader>gb', ':GBrowse', { buffer = bufnr, desc = '[B]rowse file' })

		end,
	},
}
