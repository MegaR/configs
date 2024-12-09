return {
	'Eandrju/cellular-automaton.nvim',
	config = function ()
		vim.keymap.set("n", "<leader>fr", "<cmd>CellularAutomaton make_it_rain<CR>")
		vim.keymap.set("n", "<leader>fg", "<cmd>CellularAutomaton game_of_life<CR>")
	end
}
