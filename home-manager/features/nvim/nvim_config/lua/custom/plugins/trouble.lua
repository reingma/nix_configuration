return {
  {
    'folke/trouble.nvim',
    config = function()
      vim.keymap.set('n', '<leader>xl', function()
        require('trouble').toggle()
      end, { desc = 'Exception [L]ist' })
    end,
  },
}
