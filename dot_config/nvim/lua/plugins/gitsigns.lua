-- VSCode-like inline diff: each hunk shows old text (red, above) and new text (green, below)
-- as a clearly-colored block.
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- Default to "coding mode": inline diff visuals OFF.
      -- Use <leader>uG to toggle ON during code review.
      show_deleted = false,
      linehl       = false,
      word_diff    = false,

      -- Subtle indicators that stay ON even while coding
      numhl        = true,  -- color the line number gutter

      -- Block-style diffs: group all deletions together, all additions together,
      -- instead of interleaving similar lines (which causes "delete / add / delete" splits).
      diff_opts = {
        algorithm = "minimal",     -- prefer pure block deletes/adds (no line pairing)
        internal = true,           -- use vim.diff so linematch below takes effect
        indent_heuristic = false,  -- disable indent-based hunk splitting on { } boundaries
        linematch = 0,             -- disable per-line matching that causes interleaving
      },
    },
    keys = {
      {
        "<leader>gv",
        function()
          vim.cmd("Gitsigns toggle_deleted")
          vim.cmd("Gitsigns toggle_linehl")
          vim.cmd("Gitsigns toggle_word_diff")
        end,
        desc = "Toggle Git inline diff view",
      },
      {
        "<F4>",
        function()
          vim.cmd("Gitsigns toggle_deleted")
          vim.cmd("Gitsigns toggle_linehl")
          vim.cmd("Gitsigns toggle_word_diff")
        end,
        desc = "Toggle Git inline diff view",
      },
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)

      -- Override highlight groups to match VSCode's diff colors closely.
      -- These are applied after the colorscheme so they survive theme reloads.
      local function set_vscode_diff_hl()
        -- Added line (new content) — vivid green background
        vim.api.nvim_set_hl(0, "GitSignsAddLn",            { bg = "#26432b" })
        -- Changed line (modified) — yellow/olive background
        vim.api.nvim_set_hl(0, "GitSignsChangeLn",         { bg = "#3a3a1f" })
        -- Deleted virtual line (the OLD content shown above the hunk) — vivid red background
        vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn",     { bg = "#4a1c1c", fg = "#ff8a8a" })
        -- Word-level highlighting within a virtual deletion line
        vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLnInLine", { bg = "#7a2828", fg = "#ffd2d2", bold = true })
        -- Word-level highlighting on additions (within the live buffer line)
        vim.api.nvim_set_hl(0, "GitSignsAddInline",        { bg = "#3f6b46", bold = true })
        -- Word-level highlighting on deletions inline
        vim.api.nvim_set_hl(0, "GitSignsDeleteInline",     { bg = "#7a2828", bold = true })
        -- Line-number gutter coloring
        vim.api.nvim_set_hl(0, "GitSignsAddNr",            { fg = "#7bc275", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsChangeNr",         { fg = "#d4b96a", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsDeleteNr",         { fg = "#e06c6c", bold = true })
      end

      set_vscode_diff_hl()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_vscode_diff_hl,
      })
    end,
  },
}
