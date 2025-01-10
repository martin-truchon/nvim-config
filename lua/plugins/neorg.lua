return {
  'nvim-neorg/neorg',
  dependencies = { 'luarocks.nvim', 'nvim-treesitter' },
  lazy = false,
  version = '*',
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              neorg = '~/neorg',
            },
            default_workspace = 'neorg',
          },
        },
      },
    }
    vim.wo.foldlevel = 99

    -- set the conceallevel to 2, but only for norg files
    vim.api.nvim_create_autocmd('filetype', {
      pattern = 'norg',
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
    })
  end,
}
