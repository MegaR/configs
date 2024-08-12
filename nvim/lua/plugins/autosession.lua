return {
	'rmagatti/auto-session',
	-- lazy = true,
	config = function()
		require("auto-session").setup {
			log_level = "error",
			pre_save_cmds = { require("neo-tree.sources.manager").close_all },
			bypass_session_save_file_types = { "neo-tree", "spectre" },
			auto_save_enabled = true,
			auto_restore_enabled = true,
			auto_session_use_git_branch = true,
			cwd_change_handling = {
				post_cwd_changed_hook = function ()
					require('lualine').refresh()
				end
			},
		}
	end,
}
