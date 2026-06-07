return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      -- VSCode のアクティビティバー風: neo-tree 上部にソース切替タブを表示
      source_selector = {
        winbar = true,
        statusline = false,
        show_scrolled_off_parent_node = true,
        sources = {
          { source = "filesystem",       display_name = "  Files " },
          { source = "git_status",       display_name = "  Git " },
          { source = "buffers",          display_name = "  Buffers " },
          { source = "document_symbols", display_name = "  Symbols " },
        },
      },
      sources = { "filesystem", "git_status", "buffers", "document_symbols" },

      -- Default tab when neo-tree opens (VSCode "Source Control" 起動時表示)
      default_source = "git_status",

      -- Custom command: open the focused file in diffview
      commands = {
        diff_with_diffview = function(state)
          local node = state.tree:get_node()
          if not node then return end
          if node.type == "directory" then
            vim.cmd("DiffviewOpen")
            return
          end
          local path = node.path
          if path and path ~= "" then
            vim.cmd("DiffviewOpen -- " .. vim.fn.fnameescape(path))
          end
        end,
      },

      -- Mouse / GUI split support (VSCode "Open to the Side" 相当)
      window = {
        mappings = {
          ["<2-LeftMouse>"]    = "open",
          ["<MiddleMouse>"]    = "open_vsplit",
          ["<S-LeftMouse>"]    = "open_split",
          ["o"] = "open",
          ["v"] = "open_vsplit",
          ["s"] = "open_split",
          ["t"] = "open_tabnew",
        },
      },

      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },

      -- In Git source:
      --   Enter / double-click → just open the file (gitsigns shows the inline diff)
      --   D                    → open side-by-side diffview for that file (fallback)
      git_status = {
        window = {
          mappings = {
            ["<cr>"]          = "open",
            ["<2-LeftMouse>"] = "open",
            ["o"]             = "open",
            ["D"]             = "diff_with_diffview",
          },
        },
      },
    },
    keys = {
      { "<leader>fe", "<cmd>Neotree toggle filesystem left<cr>",       desc = "Explorer: Files" },
      { "<leader>fb", "<cmd>Neotree toggle buffers left<cr>",          desc = "Explorer: Buffers" },
      { "<leader>fg", "<cmd>Neotree toggle git_status left<cr>",       desc = "Explorer: Git changes" },
      { "<leader>fs", "<cmd>Neotree toggle document_symbols left<cr>", desc = "Explorer: Symbols" },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",                          desc = "Source Control: Full Diff" },
    },
  },

  -- snacks.explorer is redundant when using neo-tree; turn it off
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },
}
