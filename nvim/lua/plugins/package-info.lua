return {
	"vuki656/package-info.nvim",
	ft = "json",
	dependencies = "MunifTanjim/nui.nvim",
	config = function()
		require('package-info').setup({
			colors = {
				up_to_date = '#3C4048',
				outdated = '#e09443',
			},
			autostart = true,
			hide_up_to_date = false,
		})

		-- Toggle dependency versions
		vim.keymap.set({ "n" }, "<LEADER>pt", require("package-info").toggle, { silent = true, noremap = true, desc = "Toggle" })
		-- Update dependency on the line
		vim.keymap.set({ "n" }, "<LEADER>pu", require("package-info").update, { silent = true, noremap = true, desc = "Update" })
		-- Delete dependency on the line
		vim.keymap.set({ "n" }, "<LEADER>pd", require("package-info").delete, { silent = true, noremap = true, desc = "Delete" })
		-- Install a new dependency
		vim.keymap.set({ "n" }, "<LEADER>pi", require("package-info").install, { silent = true, noremap = true, desc = "Install" })
		-- Install a different dependency version
		vim.keymap.set({ "n" }, "<LEADER>pp", require("package-info").change_version, { silent = true, noremap = true, desc = "Change Version" })
	end,
}
