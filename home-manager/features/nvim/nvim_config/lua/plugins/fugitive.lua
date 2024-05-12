return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [S]tage Interface' })
    vim.keymap.set('n', '<leader>gu', '<cmd>diffget //2<CR>', { desc = '[G]it [U]pstream' })
    vim.keymap.set('n', '<leader>gh', '<cmd>diffget //3<CR>', { desc = '[G]it [H]ead' })
  end,
}
