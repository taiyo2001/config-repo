return {
  "ibhagwan/fzf-lua",
  opts = {
    files = {
      fd_opts = "--color=never --type f --hidden --follow --exclude .git",
    },
    grep = {
      rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden --glob=!.git/",
    },
  },
}
