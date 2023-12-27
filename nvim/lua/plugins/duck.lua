return {
	'tamton-aquib/duck.nvim',
	config = function()
		vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, { desc = 'Duck Hatch'})
		vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, { desc = 'Duck Cook'})
	end
}
