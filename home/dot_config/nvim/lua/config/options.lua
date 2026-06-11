-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Wrap long lines visually (no actual newline inserted)
vim.opt.wrap = true
vim.opt.linebreak = true   -- 単語境界で折り返す(語の途中で切れない)
vim.opt.breakindent = true -- 折り返し行のインデントを保持

-- Use neo-tree as the file explorer (disables snacks.explorer auto-open)
vim.g.lazyvim_explorer = "neo-tree"

-- Format on save (VSCode "Editor: Format On Save")
vim.g.autoformat = true

-- Mouse support in all modes
vim.opt.mouse = "a"

-- Allow the cursor to move one position past the last character (VSCode-like)
vim.opt.virtualedit = "onemore"

-- Filetype detection for extensions not recognized by default
vim.filetype.add({
  extension = {
    tmpl = "gotmpl", -- fallback: plain .tmpl → gotmpl
  },
  filename = {
    Brewfile = "ruby",
  },
})

-- Disable diff linematch globally so deletions group together (no interleaving).
-- Default in recent Neovim contains linematch:60 which pairs similar lines.
vim.opt.diffopt:remove("linematch:60")
vim.opt.diffopt:remove("linematch:50")
vim.opt.diffopt:remove("linematch:40")
