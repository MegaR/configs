return {
	'polarmutex/git-worktree.nvim',
	config = function()
		local worktree = require("git-worktree")
		worktree.setup({
			clear_jumps_on_change = false,
			update_on_change = false,
		});
		worktree.on_tree_change(function(op)
			if op == worktree.Operations.Switch then
				vim.api.nvim_command("SessionRestore")
			end
		end);
		require("telescope").load_extension("git_worktree")
		vim.keymap.set('n', '<leader>gw', function()
			require('telescope').extensions.git_worktree.git_worktrees()
		end, { desc = 'Change [W]orktree' })
	end,
	event = "VeryLazy",
}
