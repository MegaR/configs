return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require('harpoon')
		harpoon:setup({})

		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			}):find()
		end

		vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
		vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[H]arpoon [A]dd" })
		vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end, { desc = "[H]arpoon [R]emove" })
		vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end, { desc = "[H]arpoon [C]lear" })
		vim.keymap.set("n", "<C-P>", function() harpoon:list():prev() end, { desc = "Harpoon [P]revious" })
		vim.keymap.set("n", "<C-N>", function() harpoon:list():next() end, { desc = "Harpoon [N]ext" })
	end
}
