return {
	'rmagatti/auto-session',
	-- lazy = true,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("auto-session").setup {
			log_level = "error",
			pre_save_cmds = { require("neo-tree.sources.manager").close_all },
			bypass_session_save_file_types = { "neo-tree" },
		}
	end,
}
