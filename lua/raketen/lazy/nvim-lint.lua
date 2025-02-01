return {
  'mfussenegger/nvim-lint',
  config = function()
    require('lint').linters.flake8.executable = 'flake8'
    vim.cmd("autocmd BufWritePost,BufEnter,TextChanged,TextChangedI *.py lua require('lint').try_lint('flake8')")
  end
}
