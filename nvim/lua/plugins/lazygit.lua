return {
	"kdheepak/lazygit.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available

		vim.keymap.set('n', '<leader>lg', ":LazyGit<cr>", { desc = '[L]azy [G]it' })
	end
}
