return {
  {
    'mrcjkb/rustaceanvim',
    lazy = false,
    config = function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.keymap.set('n', '<leader>cr', function()
        vim.cmd.RustLsp 'codeAction'
      end, { silent = true, buffer = bufnr, desc = '[C]ode [R]ust action ' })
    end,
  },
}
