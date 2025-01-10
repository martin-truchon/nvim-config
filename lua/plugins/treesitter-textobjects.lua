return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
          },
        },
      },
    }
  end,
}
