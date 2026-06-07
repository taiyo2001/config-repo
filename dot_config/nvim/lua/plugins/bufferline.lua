-- Customize the tab bar (bufferline) to support mouse-driven splits
return {
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      -- Middle-click a tab → open that buffer in a vertical split (VSCode "Open to the Side")
      opts.options.middle_mouse_command = "vert sbuffer %d"
      -- Left-click switches to that buffer (default), keep as-is.
      -- Right-click closes the buffer (LazyVim default).
      return opts
    end,
  },
}
