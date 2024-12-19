return {
    'Eandrju/cellular-automaton.nvim',
    config = function()
        vim.keymap.set('n', '<leader>Fr', '<cmd>CellularAutomaton make_it_rain<CR>')
        vim.keymap.set('n', '<leader>Fg', '<cmd>CellularAutomaton game_of_life<CR>')
    end,
}
