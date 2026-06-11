#!/usr/bin/env bats
# Smoke tests for dotfiles source structure.
# These tests verify that key files exist and the repo layout is correct.
# They do NOT require chezmoi apply or 1Password.

REPO_ROOT="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"

# --- chezmoiroot ---

@test ".chezmoiroot exists" {
  [ -f "$REPO_ROOT/.chezmoiroot" ]
}

@test ".chezmoiroot points to 'home'" {
  run cat "$REPO_ROOT/.chezmoiroot"
  [ "$status" -eq 0 ]
  [ "$output" = "home" ]
}

@test ".chezmoi.toml.tmpl is at repo root, not inside home/" {
  [ -f "$REPO_ROOT/.chezmoi.toml.tmpl" ]
  [ ! -f "$REPO_ROOT/home/.chezmoi.toml.tmpl" ]
}

# --- key dotfiles ---

@test "home/dot_zshrc exists" {
  [ -f "$REPO_ROOT/home/dot_zshrc" ]
}

@test "home/dot_gitconfig.tmpl exists" {
  [ -f "$REPO_ROOT/home/dot_gitconfig.tmpl" ]
}

@test "home/dot_Brewfile exists" {
  [ -f "$REPO_ROOT/home/dot_Brewfile" ]
}

@test "home/dot_tmux.conf exists" {
  [ -f "$REPO_ROOT/home/dot_tmux.conf" ]
}

@test "home/dot_config/starship.toml exists" {
  [ -f "$REPO_ROOT/home/dot_config/starship.toml" ]
}

@test "home/dot_config/ghostty/config exists" {
  [ -f "$REPO_ROOT/home/dot_config/ghostty/config" ]
}

@test "home/dot_config/nvim/init.lua exists" {
  [ -f "$REPO_ROOT/home/dot_config/nvim/init.lua" ]
}

# --- zsh modules ---

@test "home/dot_zsh/exports.zsh exists" {
  [ -f "$REPO_ROOT/home/dot_zsh/exports.zsh" ]
}

@test "home/dot_zsh/aliases.zsh exists" {
  [ -f "$REPO_ROOT/home/dot_zsh/aliases.zsh" ]
}

@test "home/dot_zsh/functions.zsh exists" {
  [ -f "$REPO_ROOT/home/dot_zsh/functions.zsh" ]
}

@test "home/dot_zsh/completions.zsh exists" {
  [ -f "$REPO_ROOT/home/dot_zsh/completions.zsh" ]
}

@test "dot_zshrc sources all modules" {
  run grep -c 'source.*\.zsh"' "$REPO_ROOT/home/dot_zshrc"
  [ "$output" -ge 4 ]
}

# --- setup scripts ---

@test "home/run_once_install-packages.sh exists" {
  [ -f "$REPO_ROOT/home/run_once_install-packages.sh" ]
}

@test "home/run_onchange_after_macos-defaults.sh exists" {
  [ -f "$REPO_ROOT/home/run_onchange_after_macos-defaults.sh" ]
}

# --- template integrity ---

@test "dot_zshrc has no unresolved chezmoi template variables" {
  run grep -c '\$\${' "$REPO_ROOT/home/dot_zshrc"
  [ "$output" = "0" ]
}

@test "dot_gitconfig.tmpl references 1Password (onepasswordRead)" {
  run grep -c 'onepasswordRead' "$REPO_ROOT/home/dot_gitconfig.tmpl"
  [ "$status" -eq 0 ]
  [ "$output" -gt 0 ]
}
