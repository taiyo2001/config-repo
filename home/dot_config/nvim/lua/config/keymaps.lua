-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ===== Edit (VSCode-style) =====
-- Cmd+Z / Cmd+Shift+Z (Undo / Redo)
map({ "n", "v" }, "<D-z>", "u", { desc = "Undo" })
map("i", "<D-z>", "<C-o>u", { desc = "Undo" })
map({ "n", "v" }, "<D-S-z>", "<C-r>", { desc = "Redo" })
map("i", "<D-S-z>", "<C-o><C-r>", { desc = "Redo" })

-- Cmd+S (Save)
map({ "n", "v" }, "<D-s>", "<cmd>w<cr>", { desc = "Save" })
map("i", "<D-s>", "<Esc><cmd>w<cr>a", { desc = "Save" })

-- Cmd+A (Select All)
map("n", "<D-a>", "ggVG", { desc = "Select all" })
map("i", "<D-a>", "<Esc>ggVG", { desc = "Select all" })

-- Cmd+C / Cmd+V / Cmd+X (system clipboard)
map("v", "<D-c>", '"+y', { desc = "Copy" })
map("v", "<D-x>", '"+d', { desc = "Cut" })
map({ "n", "v" }, "<D-v>", '"+p', { desc = "Paste" })
map("i", "<D-v>", "<C-r>+", { desc = "Paste" })
map("c", "<D-v>", "<C-r>+", { desc = "Paste" })

-- ===== Navigation (VSCode-style) =====
-- Ctrl+P / Cmd+P (Quick Open) → file picker
local function quick_open()
  if pcall(require, "snacks") then
    require("snacks").picker.files()
  else
    vim.cmd("Telescope find_files")
  end
end
map({ "n", "v" }, "<C-p>", quick_open, { desc = "Quick Open (files)" })
map({ "n", "i", "v" }, "<D-p>", quick_open, { desc = "Quick Open (files)" })

-- Cmd+Shift+P (Command Palette)
map({ "n", "i", "v" }, "<D-S-p>", function()
  if pcall(require, "snacks") then
    require("snacks").picker.commands()
  else
    vim.cmd("Telescope commands")
  end
end, { desc = "Command Palette" })

-- Cmd+Shift+O (Go to Symbol in file)
map({ "n", "i" }, "<D-S-o>", function()
  if pcall(require, "snacks") then
    require("snacks").picker.lsp_symbols()
  else
    vim.cmd("Telescope lsp_document_symbols")
  end
end, { desc = "Go to Symbol in file" })

-- ===== View / Layout (VSCode-style) =====
-- Cmd+B (Toggle Sidebar / Neo-tree)
map({ "n", "i", "v" }, "<D-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Sidebar" })

-- Ctrl+Shift+E / Cmd+Shift+E (Focus Files in sidebar)
map({ "n", "i", "v" }, "<C-S-e>", "<cmd>Neotree focus filesystem left<cr>", { desc = "Sidebar: Files" })
map({ "n", "i", "v" }, "<D-S-e>", "<cmd>Neotree focus filesystem left<cr>", { desc = "Sidebar: Files" })

-- Ctrl+Shift+G / Cmd+Shift+G (Focus Git changes in sidebar)
map({ "n", "i", "v" }, "<C-S-g>", "<cmd>Neotree focus git_status left<cr>", { desc = "Sidebar: Git changes" })
map({ "n", "i", "v" }, "<D-S-g>", "<cmd>Neotree focus git_status left<cr>", { desc = "Sidebar: Git changes" })

-- Cmd+` (Toggle integrated terminal)
map({ "n", "i", "v" }, "<D-`>", function()
  if pcall(require, "snacks") then
    require("snacks").terminal.toggle()
  else
    vim.cmd("terminal")
  end
end, { desc = "Toggle Terminal" })
map("t", "<D-`>", [[<C-\><C-n><cmd>close<cr>]], { desc = "Hide Terminal" })

-- Cmd+\ (Split Editor right)
map({ "n", "i", "v" }, "<D-\\>", "<cmd>vsplit<cr>", { desc = "Split Editor Right" })

-- Cmd+W (Close current buffer)
map({ "n", "i", "v" }, "<D-w>", function()
  if pcall(require, "snacks") then
    require("snacks").bufdelete()
  else
    vim.cmd("bdelete")
  end
end, { desc = "Close Editor" })

-- ===== Find / Replace =====
-- Cmd+F (Find in file) — start `/` search
map({ "n", "v" }, "<D-f>", "/", { desc = "Find in file" })
map("i", "<D-f>", "<Esc>/", { desc = "Find in file" })

-- Cmd+Shift+F (Find in files / Live grep)
map({ "n", "i", "v" }, "<D-S-f>", function()
  if pcall(require, "snacks") then
    require("snacks").picker.grep()
  else
    vim.cmd("Telescope live_grep")
  end
end, { desc = "Find in Files" })

-- ===== Code =====
-- Cmd+/ (Toggle Comment) — uses LazyVim's gcc / gc operator under the hood
map("n", "<D-/>", "gcc", { remap = true, desc = "Toggle Line Comment" })
map("v", "<D-/>", "gc", { remap = true, desc = "Toggle Comment" })
map("i", "<D-/>", "<Esc>gcca", { remap = true, desc = "Toggle Line Comment" })

-- Cmd+. (Code Action / Quick Fix)
map({ "n", "v" }, "<D-.>", vim.lsp.buf.code_action, { desc = "Code Action" })
map("i", "<D-.>", "<Esc><cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action" })

-- F2 (Rename Symbol)
map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })

-- F12 / Shift+F12 (Go to Definition / Find References)
map("n", "<F12>", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "<S-F12>", vim.lsp.buf.references, { desc = "Find References" })

-- Alt+Up / Alt+Down (Move line up/down) — VSCode default
map("n", "<A-Up>",   "<cmd>m .-2<cr>==",       { desc = "Move line up" })
map("n", "<A-Down>", "<cmd>m .+1<cr>==",       { desc = "Move line down" })
map("v", "<A-Up>",   ":m '<-2<cr>gv=gv",       { desc = "Move selection up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv",       { desc = "Move selection down" })
map("i", "<A-Up>",   "<Esc><cmd>m .-2<cr>==gi",{ desc = "Move line up" })
map("i", "<A-Down>", "<Esc><cmd>m .+1<cr>==gi",{ desc = "Move line down" })

-- Shift+Alt+Up / Down (Copy line up/down)
map("n", "<S-A-Up>",   "yyP", { desc = "Copy line up" })
map("n", "<S-A-Down>", "yyp", { desc = "Copy line down" })

-- ===== Settings (Cmd+,) =====
map({ "n", "i", "v" }, "<D-,>", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Open Settings (init.lua)" })
