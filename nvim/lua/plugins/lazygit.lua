return {
	"kdheepak/lazygit.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.keymap.set('n', '<leader>lg', ":LazyGit<cr>", { desc = '[L]azy [G]it' })
	end
}
