return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	config = function()
		require('noice').setup({
			-- add any options here
			lsp = {
				signature = {
					enabled = false,
				},
			},
			views = {
				mini = {
					win_options = {
						-- winblend = 0,
						-- winhighlight = {
						-- 	Normal = nil,
						-- },
					},
				},
			},
		})
---@diagnostic disable-next-line: missing-fields
		require("notify").setup({
			background_colour = "#000000",
		})
	end
}
