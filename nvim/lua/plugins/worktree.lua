return {
	'polarmutex/git-worktree.nvim',
	config = function()
		require("telescope").load_extension("git_worktree")
		vim.keymap.set('n', '<leader>gw', function()
			require('telescope').extensions.git_worktree.git_worktrees()
		end, { desc = 'Change [W]orktree' })
	end,
	event = "VeryLazy",
}
