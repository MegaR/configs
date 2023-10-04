-- Useful plugin to show you pending keybinds.
return {
	'folke/which-key.nvim',
	opts = {},
	config = function()
		local wk = require('which-key')

		wk.register({
			g = {
				name = "Git",
			},
		}, { prefix = "<leader>" })

		wk.register({
			c = {
				name = "Code",
			},
		}, { prefix = "<leader>" })

		wk.register({
			r = {
				name = "Rename",
			},
		}, { prefix = "<leader>" })

		wk.register({
			s = {
				name = "Search",
			},
		}, { prefix = "<leader>" })

		wk.register({
			w = {
			name = "Workspace",
			},
		}, { prefix = "<leader>" })

	end
}
