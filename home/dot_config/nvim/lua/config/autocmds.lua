-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- When launching `nvim <dir>`, prefer the git_status source over filesystem
-- (LazyVim's netrw hijack opens "filesystem" explicitly, bypassing default_source).
-- Runs both on a delayed VimEnter (no-session case) and after persistence.load() finishes.
local neotree_default = vim.api.nvim_create_augroup("user_neotree_default_git", { clear = true })

local function switch_to_git_status_if_dir()
  if vim.fn.argc(-1) ~= 1 then return end
  if vim.fn.isdirectory(vim.fn.argv(0)) ~= 1 then return end
  pcall(function()
    vim.cmd("Neotree close")
    vim.cmd("Neotree show git_status left")
  end)
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = neotree_default,
  nested = true,
  callback = function()
    vim.defer_fn(switch_to_git_status_if_dir, 500)
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = neotree_default,
  pattern = "PersistenceLoadPost",
  callback = function()
    vim.schedule(switch_to_git_status_if_dir)
  end,
})

-- Disable trackpad horizontal scroll inside neo-tree buffers
local neotree_noscroll = vim.api.nvim_create_augroup("user_neotree_noscroll", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = neotree_noscroll,
  pattern = "neo-tree",
  callback = function(args)
    for _, key in ipairs({ "<ScrollWheelLeft>", "<ScrollWheelRight>", "<S-ScrollWheelUp>", "<S-ScrollWheelDown>" }) do
      pcall(vim.keymap.set, "n", key, "<Nop>", { buffer = args.buf, silent = true })
    end
  end,
})

-- Auto-save when leaving insert mode or losing focus (VSCode "Files: Auto Save = onFocusChange")
local autosave = vim.api.nvim_create_augroup("user_autosave", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost", "BufLeave" }, {
  group = autosave,
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.modifiable and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})

-- Auto-restore the previous session when launching `nvim` (no args) or `nvim <dir>`.
-- VSCode-like "Restore Windows: all" behavior.
local restore = vim.api.nvim_create_augroup("user_session_autorestore", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = restore,
  nested = true,
  callback = function()
    local argc = vim.fn.argc(-1)
    local should_load = argc == 0
    if not should_load and argc == 1 then
      local arg0 = vim.fn.argv(0)
      if vim.fn.isdirectory(arg0) == 1 then
        should_load = true
      end
    end
    if should_load then
      pcall(function()
        require("persistence").load()
      end)
    end
  end,
})
