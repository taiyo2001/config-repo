return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "gotmpl",    -- chezmoi .tmpl files
        "go",
        "dockerfile",
        "hcl",       -- Terraform
        "terraform",
        "sql",
        "proto",
      })
    end,
  },
}
