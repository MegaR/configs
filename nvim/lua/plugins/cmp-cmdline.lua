return {
	'hrsh7th/cmp-cmdline',
	config = function()
		local cmp = require('cmp')
		---@diagnostic disable-next-line: missing-fields
		cmp.setup.cmdline('/', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		---@diagnostic disable-next-line: missing-fields
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{
					name = 'cmdline',
					option = {
						ignore_cmds = { 'Man', '!' }
					}
				}
			})
		})
	end
}
