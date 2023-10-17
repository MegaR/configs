return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = {
		vim.keymap.set('n', '<leader>q', function() require("trouble").toggle() end, { desc = 'Open diagnostics list' })
	}
}
