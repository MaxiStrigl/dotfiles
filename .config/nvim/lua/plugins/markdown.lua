return {
  'MeanderingProgrammer/markdown.nvim',
  main = "render-markdown",
  opts = {},
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },

  config = function()
    require('render-markdown').setup({
      latex = {
        enabled = false,
        converter = 'latex2text',
        highlight = 'RenderMarkdownMath',
        top_pad = 0,
        bottom_pad = 0,
      }
    })
  end
}
