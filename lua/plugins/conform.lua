vim.api.nvim_create_user_command('DisableFormat', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { desc = 'Disable autoformat-on-save', bang = true })

vim.api.nvim_create_user_command('EnableFormat', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { desc = 'Enable autoformat-on-save', bang = true })

return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { lsp_format = 'fallback' }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'eslint-lsp' },
      typescript = { 'eslint-lsp' },
      typescriptreact = { 'eslint-lsp' },
    },
  },
}
