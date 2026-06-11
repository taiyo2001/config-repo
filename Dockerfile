FROM ubuntu:22.04

ARG USERNAME=ubuntu
ENV DEBIAN_FRONTEND=noninteractive
ENV CI=true
ENV PATH="/home/ubuntu/.local/bin:/home/ubuntu/.local/share/mise/shims:${PATH}"

# mise でインストールできないもののみ apt で取得
RUN apt-get update && apt-get install -y \
      zsh git curl make sudo unzip ca-certificates tmux \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user with sudo
RUN useradd -m -s /bin/zsh ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}

# mise（他ツールのインストーラーとして最初に入れる）
RUN curl https://mise.run | sh

# mise で全ツールをまとめてインストール
RUN mise use -g chezmoi@latest starship@latest direnv@latest \
      fzf@latest eza@latest bat@latest ghq@latest peco@latest

# zsh plugins at /opt/homebrew to match macOS dotfiles paths
RUN sudo mkdir -p /opt/homebrew/share /opt/homebrew/etc/profile.d \
    && sudo git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
         /opt/homebrew/share/zsh-autosuggestions \
    && sudo git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
         /opt/homebrew/share/zsh-syntax-highlighting \
    && sudo curl -fsSL https://raw.githubusercontent.com/rupa/z/master/z.sh \
         -o /opt/homebrew/etc/profile.d/z.sh

# mock op (1Password CLI stub for Docker testing)
RUN printf '#!/bin/bash\ncase "$*" in\n  *"git config email"*) echo "docker@test.local" ;;\n  *"git config signingkey"*) echo "DOCKER_TEST_KEY" ;;\n  *"claude code org_uuid"*) echo "docker-test-uuid" ;;\n  *) echo "" ;;\nesac\n' \
    > ~/.local/bin/op && chmod +x ~/.local/bin/op

# Copy dotfiles repo
COPY --chown=${USERNAME}:${USERNAME} . /home/${USERNAME}/.local/share/chezmoi

# .git は .dockerignore で除外されているため git リポジトリを初期化
RUN git -C ~/.local/share/chezmoi init -b main \
    && git -C ~/.local/share/chezmoi config user.email "docker@test.local" \
    && git -C ~/.local/share/chezmoi config user.name "docker" \
    && git -C ~/.local/share/chezmoi add -A \
    && git -C ~/.local/share/chezmoi commit -m "dotfiles snapshot" --quiet

# Pre-create chezmoi config (bypasses promptStringOnce for non-interactive Docker)
RUN mkdir -p ~/.config/chezmoi \
    && printf '[data]\n    personal    = true\n    work        = false\n    fullInstall = false\n\n[onepassword]\n    command = "op"\n' \
       > ~/.config/chezmoi/chezmoi.toml

# Apply dotfiles
RUN chezmoi apply \
    && git config --global user.name "docker" \
    && git config --global user.email "docker@test.local"

# chezmoi リポジトリをデフォルト作業ディレクトリに（git ブランチをプロンプトに表示するため）
WORKDIR /home/ubuntu/.local/share/chezmoi

CMD ["zsh"]
