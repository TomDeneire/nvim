return
{
  "NvChad/nvterm",
  config = function()
    require("nvterm").setup()
  end,
  lazy = true,
  keys = {
    { "<leader>term", "<cmd>silent lua require('nvterm.terminal').toggle 'horizontal'<cr>", silent = true,
      desc = "Start terminal", mode = "n" } },
}
