return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/nvim-nio',
    'marilari88/neotest-vitest',
  },
  config = function()
    local neotest = require 'neotest'
    neotest.setup {
      adapters = {
        require 'neotest-vitest',
      },
    }
    vim.keymap.set('n', '<leader>tr', function()
      neotest.run.run()
    end, { desc = '[T]est [R]un' })
  end,
}
