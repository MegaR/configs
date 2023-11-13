return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			filesystem = {
				follow_current_file = {
					enabled = false,
					leave_dirs_open = false,
				},
				use_libuv_file_watcher = true,
			},
			window = {
				position = "right",
			},
			default_component_configs = {
				git_status = {
					symbols = {
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						-- conflict = "",
					},
				},
			},
		})
	end,
}
