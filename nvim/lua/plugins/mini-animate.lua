return {
	'echasnovski/mini.animate',
	version = false,
	config = function ()
		require('mini.animate').setup({
			scroll = {
				enable = false,
			},
		})
	end
}
