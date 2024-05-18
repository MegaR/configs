return {
	'mrjones2014/smart-splits.nvim',
	config = function()
		local ss = require('smart-splits')
		local opts = {
			multiplexer_integration = 'wezterm',
			at_edge = 'stop',
			on_enter = function()
				require('tint').refresh()
			end,
		}

		local utils = require('smart-splits.mux.utils')
		if utils.are_we_wezterm() and utils.is_WSL() then
			opts["wezterm_cli_path"] = "wezterm.exe"
		end

		ss.setup(opts)

		vim.keymap.set('n', '<C-S-h>', ss.move_cursor_left)
		vim.keymap.set('n', '<C-S-j>', ss.move_cursor_down)
		vim.keymap.set('n', '<C-S-k>', ss.move_cursor_up)
		vim.keymap.set('n', '<C-S-l>', ss.move_cursor_right)

		vim.keymap.set('n', '<A-h>', ss.resize_left)
		vim.keymap.set('n', '<A-j>', ss.resize_down)
		vim.keymap.set('n', '<A-k>', ss.resize_up)
		vim.keymap.set('n', '<A-l>', ss.resize_right)

		vim.keymap.set('n', '<leader><leader>h', ss.swap_buf_left)
		vim.keymap.set('n', '<leader><leader>j', ss.swap_buf_down)
		vim.keymap.set('n', '<leader><leader>k', ss.swap_buf_up)
		vim.keymap.set('n', '<leader><leader>l', ss.swap_buf_right)
	end
}
