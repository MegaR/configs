return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function ()
		local trouble = require("trouble")
		vim.keymap.set('n', '<leader>q', function() trouble.toggle("diagnostics") end, { desc = 'Open diagnostics list' })
	end,
}
