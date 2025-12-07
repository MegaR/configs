return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'folke/snacks.nvim' },
    config = function()
        local harpoon = require 'harpoon'
        harpoon:setup {}

        -- local conf = require("telescope.config").values
        -- local function toggle_telescope(harpoon_files)
        -- 	local file_paths = {}
        -- 	for _, item in ipairs(harpoon_files.items) do
        -- 		table.insert(file_paths, item.value)
        -- 	end
        --
        -- 	require("telescope.pickers").new({}, {
        -- 		prompt_title = "Harpoon",
        -- 		finder = require("telescope.finders").new_table({
        -- 			results = file_paths,
        -- 		}),
        -- 		previewer = conf.file_previewer({}),
        -- 		sorter = conf.generic_sorter({}),
        -- 	}):find()
        -- end

        -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
        local normalize_list = function(t)
            local normalized = {}
            for _, v in pairs(t) do
                if v ~= nil then
                    table.insert(normalized, v)
                end
            end
            return normalized
        end

        vim.keymap.set('n', '<C-e>', function()
            Snacks.picker {
                finder = function()
                    local file_paths = {}
                    local list = normalize_list(harpoon:list().items)
                    for i, item in ipairs(list) do
                        table.insert(file_paths, { text = item.value, file = item.value })
                    end
                    return file_paths
                end,
                win = {
                    input = {
                        keys = { ['dd'] = { 'harpoon_delete', mode = { 'n', 'x' } } },
                    },
                    list = {
                        keys = { ['dd'] = { 'harpoon_delete', mode = { 'n', 'x' } } },
                    },
                },
                actions = {
                    harpoon_delete = function(picker, item)
                        local to_remove = item or picker:selected()
                        harpoon:list():remove { value = to_remove.text }
                        harpoon:list().items = normalize_list(harpoon:list().items)
                        picker:find { refresh = true }
                    end,
                },
            }
        end)
        vim.keymap.set('n', '<leader>ha', function()
            harpoon:list():add()
        end, { desc = '[H]arpoon [A]dd' })
        vim.keymap.set('n', '<leader>hr', function()
            harpoon:list():remove()
        end, { desc = '[H]arpoon [R]emove' })
        vim.keymap.set('n', '<leader>hc', function()
            harpoon:list():clear()
        end, { desc = '[H]arpoon [C]lear' })
        vim.keymap.set('n', '<C-P>', function()
            harpoon:list():prev()
        end, { desc = 'Harpoon [P]revious' })
        vim.keymap.set('n', '<C-N>', function()
            harpoon:list():next()
        end, { desc = 'Harpoon [N]ext' })
    end,
}
