return {
  -- VSCode Dark+ ライクな配色
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      italic_comments = true,
      underline_links = true,
      terminal_colors = true,
    },
    config = function(_, opts)
      vim.o.background = "dark"
      require("vscode").setup(opts)
    end,
  },

  -- LazyVim にデフォルトカラースキームとして適用させる
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
