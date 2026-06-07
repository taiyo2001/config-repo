return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview (working tree)" },
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
    { "<leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "File history (branch)" },
  },
  opts = {
    -- VSCode の inline diff に近い縦並びレイアウト
    -- 上: 変更前(削除行が赤) / 下: 変更後(追加行が緑)
    enhanced_diff_hl = true, -- 単語単位のハイライト強化(VSCode風)
    view = {
      default      = { layout = "diff2_vertical" },
      file_history = { layout = "diff2_vertical" },
    },
  },
}
