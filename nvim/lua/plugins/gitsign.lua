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
			vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
				{ buffer = bufnr, desc = '[P]revious Hunk' })
			vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
				{ buffer = bufnr, desc = '[N]ext Hunk' })
			vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk,
				{ buffer = bufnr, desc = '[P]review Hunk' })
			vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk,
				{ buffer = bufnr, desc = '[R]eset Hunk' })
			vim.keymap.set('n', '<leader>gs', require('gitsigns').stage_hunk,
				{ buffer = bufnr, desc = '[S]tage Hunk' })
			vim.keymap.set('n', '<leader>gu', require('gitsigns').undo_stage_hunk,
				{ buffer = bufnr, desc = '[U]nstage Hunk' })
			vim.keymap.set('n', '<leader>gb', require('gitsigns').toggle_current_line_blame,
				{ buffer = bufnr, desc = 'git [b]lame' })
			vim.keymap.set('n', '<leader>gB', ':GBrowse', { buffer = bufnr, desc = '[B]rowse file' })
		end,
	},
}
