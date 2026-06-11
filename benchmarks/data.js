window.BENCHMARK_DATA = {
  "lastUpdate": 1781192187592,
  "repoUrl": "https://github.com/taiyo2001/dotfiles",
  "entries": {
    "Zsh Startup Time": [
      {
        "commit": {
          "author": {
            "email": "100068523+taiyo2001@users.noreply.github.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "35fd3aa4a0aa5c1dae3f8c209d893c7b3b088685",
          "message": "feat: Bats スモークテストと zsh 起動速度ベンチマークを CI に追加 (#10)\n\n* feat: Bats スモークテストと zsh 起動速度ベンチマークを CI に追加\n\n- tests/smoke.bats を新規作成\n  - .chezmoiroot の存在・内容確認\n  - home/ 以下の主要 dotfiles の存在確認\n  - テンプレート変数の未解決チェック\n- CI に bats-smoke-test ジョブを追加（ubuntu-latest）\n- CI に startup-benchmark ジョブを追加（macos-latest）\n  - hyperfine で zsh 起動時間を計測\n  - 500ms 超で fail、150ms 超で warning\n\nCloses #8\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* feat: zsh 起動速度を GitHub Pages にグラフで記録\n\nbenchmark-action/github-action-benchmark を使用し、\nhyperfine の計測結果を gh-pages ブランチの benchmarks/ に蓄積。\n- main へのマージ時のみ gh-pages へ自動 push\n- ベースラインから 150% 以上遅くなった場合に PR へコメント通知\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* fix: benchmark の gh-pages 保存を main のみに限定\n\ngh-pages ブランチが存在しない状態で PR から fetch しようとして\nfatal: couldn't find remote ref gh-pages で失敗していた問題を修正。\nStore benchmark result ステップに if: github.ref == 'refs/heads/main' を追加し、\nmain マージ時のみ gh-pages に書き込むよう変更。\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n---------\n\nCo-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-11T02:47:34+09:00",
          "tree_id": "7543d8a6b1ee3e391e86990a7cf003f43062a364",
          "url": "https://github.com/taiyo2001/dotfiles/commit/35fd3aa4a0aa5c1dae3f8c209d893c7b3b088685"
        },
        "date": 1781113855066,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 214.47,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "taiyo2778@gmail.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "taiyo2778@gmail.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "distinct": true,
          "id": "74c5e3bd0f9153b08da6b5296238e44b80e58825",
          "message": "docs: README に Zsh Startup Benchmark のリンクを追加\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-11T03:04:28+09:00",
          "tree_id": "1aae2b4700b22269c7b5a0b2f4cded0ef24eba08",
          "url": "https://github.com/taiyo2001/dotfiles/commit/74c5e3bd0f9153b08da6b5296238e44b80e58825"
        },
        "date": 1781114700804,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 245.02,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "taiyo2778@gmail.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "taiyo2778@gmail.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "distinct": true,
          "id": "a8280d3dd9714d8eafd8390c53748e64d6c5d0d9",
          "message": "chore: Renovate を追加（GitHub Actions 月次更新）\n\nenabledManagers を github-actions のみに限定し、\n毎月1日に更新 PR を作成する設定。\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-11T03:13:11+09:00",
          "tree_id": "98f9205496a240d92d3d9a239715a54aaea1d68f",
          "url": "https://github.com/taiyo2001/dotfiles/commit/a8280d3dd9714d8eafd8390c53748e64d6c5d0d9"
        },
        "date": 1781115231399,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 278.55,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "100068523+taiyo2001@users.noreply.github.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "2407feac8fbfee2e58a0eb6666eb23a49b509ccb",
          "message": "feat: zsh 環境を全面刷新（モジュール化・最適化・mise 移行・lefthook） (#12)\n\n* feat: zshrc をモジュール化し起動速度を最適化\n\nモジュール化（dot_zsh/ 以下に分割）:\n- exports.zsh: 環境変数・PATH\n- aliases.zsh: エイリアス\n- functions.zsh: 関数・fzf キーバインド\n- completions.zsh: 補完設定・compinit\n\n起動速度最適化:\n- BREW_PREFIX=\"/opt/homebrew\" を変数化し brew --prefix 呼び出しを削除\n- compinit を 24h キャッシュ化（.zcompdump が新鮮なら compinit -C）\n- kubectl completion をファイルキャッシュ化（~/.cache/、週次更新）\n\nCloses #8\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* feat: lefthook で pre-push ローカル CI を設定\n\nプッシュ前に以下を自動実行してリモート CI での失敗を防ぐ：\n- shfmt フォーマットチェック\n- shellcheck\n- テンプレート変数チェック\n- Bats スモークテスト\n\nまた make ci/local で手動実行も可能。\nsetup/apply 時に lefthook install を自動実行するよう変更。\nbats-core を Brewfile に追加。\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* docs: README を最新の構成・CI フローに合わせて更新\n\n- 構成表に home/, home/dot_zsh/, tests/ を追加\n- setup/apply を make コマンドに変更（lefthook install を含む）\n- CI / 品質チェックセクションを追加（ci/local, pre-push フック, format）\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* style: shfmt フォーマットを修正（リダイレクトのスペース）\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* docs: 依存ツールに bats-core と lefthook を追加\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* chore: zsh の不要な設定を削除\n\n- zsh-git-prompt, vcs_info, PS1, git_prompt_info を削除\n  （starship が上書きするため完全に冗長だった）\n- ANDROID_HOME と Android の PATH を削除\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* feat: asdf から mise へ完全移行\n\n- dot_zshrc: . ~/.asdf/asdf.sh → eval \"$(mise activate zsh)\"\n- completions.zsh: asdf which terraform → mise which terraform\n- dot_asdfrc を削除（legacy_version_file は mise のデフォルトで有効）\n- Brewfile から zsh-git-prompt を削除\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n---------\n\nCo-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-11T11:33:38+09:00",
          "tree_id": "7e73a0d07f3a3fe5874942f56b60e55c36af20b4",
          "url": "https://github.com/taiyo2001/dotfiles/commit/2407feac8fbfee2e58a0eb6666eb23a49b509ccb"
        },
        "date": 1781145256109,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 97.24,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "100068523+taiyo2001@users.noreply.github.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "656e75964f3f3f36cc90b98ea8c9532de293a350",
          "message": "feat: マルチマシン対応・Brewfile テンプレート化・brew 自動更新・Neovim tmpl ハイライト (#13)\n\n### マルチマシン対応\n- .chezmoi.toml.tmpl に machineType / fullInstall を追加\n- dot_Brewfile → dot_Brewfile.tmpl に変換し4セクションに分割\n  - Core: 常にインストールする CLI・GUI ツール\n  - Personal: BTT / Hammerspoon / TablePlus 等\n  - Work: （将来の追加用）\n  - Full install: imagemagick 等の重いライブラリ・インフラツール\n\n### brew 自動更新（毎週日曜 10:00）\n- ~/.local/bin/brew-upgrade.sh: update → upgrade → terminal-notifier 通知\n- ~/Library/LaunchAgents/local.brew-upgrade.plist: launchd 定義\n- run_onchange スクリプトで chezmoi apply 時に自動ロード\n\n### Neovim .tmpl シンタックスハイライト\n- autocmds.lua: *.toml.tmpl → toml, dot_Brewfile.tmpl → ruby 等の autocmd\n- options.lua: 拡張子 tmpl → gotmpl フォールバック, Brewfile → ruby\n- plugins/treesitter.lua: gotmpl, go, dockerfile, hcl, terraform, sql, proto を追加\n\nCo-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-11T12:37:58+09:00",
          "tree_id": "a283c2fe90b940dd36f41becf015daf3e448f4bb",
          "url": "https://github.com/taiyo2001/dotfiles/commit/656e75964f3f3f36cc90b98ea8c9532de293a350"
        },
        "date": 1781149103849,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 39.48,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "100068523+taiyo2001@users.noreply.github.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "76639cb0a50953e5727b1411250a2b20f5c96f80",
          "message": "docs: README 充実化・.chezmoiversion 追加 (#14)\n\n- バッジ（CI・chezmoi・Zsh Benchmark）を冒頭に追加\n- 概要文と技術スタック表を追加\n- .chezmoiversion に v2.70.5 を設定（最低バージョン要件を明示）\n\nCo-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-11T16:08:55+09:00",
          "tree_id": "0442c2b3677c51ec2e1f5b5a49dfe5e83dfd7b4b",
          "url": "https://github.com/taiyo2001/dotfiles/commit/76639cb0a50953e5727b1411250a2b20f5c96f80"
        },
        "date": 1781161761302,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 38.59,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "100068523+taiyo2001@users.noreply.github.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "d8cf015003e1545b46552b44d41ef1af9647e40e",
          "message": "docs: README 全面改善・macOS 設定に確認プロンプト追加 (#15)\n\n* docs: スクリーンショット追加・README レイアウト改善\n\n- docs/screenshot.png を追加\n- タイトルに 🏠 絵文字を付けて中央寄せ\n- バッジ・概要・スクリーンショットを div[align=center] で中央寄せ\n- 技術スタック・構成テーブルを HTML table[width=100%] に変更\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* docs: README 全面改善・macOS 設定に確認プロンプト追加\n\n- スクリーンショット追加・タイトルと冒頭を中央寄せ\n- バッジ・技術スタック・構成・1Password テーブルを全幅 HTML に変更\n- セットアップ手順を新規 Mac から始められる最小ステップに整理\n  - Homebrew インストールをステップ1に追加\n  - make・1password（cask）を依存に追加、不要な brew install を削減\n  - brew bundle は chezmoi apply 経由で自動実行されるためステップから削除\n  - lefthook install は make setup/apply で自動実行される旨を明記\n- macOS デフォルト設定スクリプトに yes/no 確認プロンプトを追加\n- Makefile から format/fix・format/check を削除（ci/local に統合）\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n---------\n\nCo-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-11T16:37:34+09:00",
          "tree_id": "d35ec6a36b01d0a5460e6110afbc4788952ad969",
          "url": "https://github.com/taiyo2001/dotfiles/commit/d8cf015003e1545b46552b44d41ef1af9647e40e"
        },
        "date": 1781163483461,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 45.17,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "100068523+taiyo2001@users.noreply.github.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "9e9f7e1644d8dc87f70672e84bf1413e14fb7e78",
          "message": "chore: リポジトリ整理・Docker サンドボックス環境整備 (#16)\n\n* chore: find_variables.sh・utils/ を削除\n\n$${...} 変数が存在しないことが確認済みのため、チェックスクリプト自体が不要となった。\n- find_variables.sh を削除\n- utils/colors.sh（find_variables.sh からのみ参照）を削除\n- Makefile から ci/local の find_variables 呼び出しと setup/check ターゲットを削除\n- lefthook.yml から template-vars フックを削除・shellcheck の ignore_paths から utils を削除\n- push_ci.yml から check-template-vars ジョブを削除・shellcheck の ignore_paths から utils を削除\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* chore: Docker 環境整備・tmux 重複削除・ci/local 簡略化\n\nDocker:\n- Ubuntu 22.04 に更新\n- chezmoi・mise・starship・direnv をインストール\n- zsh プラグインを /opt/homebrew 配下に配置（macOS パスと一致させる）\n- mock op コマンドを追加（1Password なしで chezmoi apply を通す）\n- chezmoi.toml を事前生成（promptStringOnce をスキップ）\n- run_once_install-packages.sh に Docker 検出を追加（/.dockerenv でスキップ）\n- compose.yml を整理（stdin_open 追加・サービス名統一）\n- Makefile の docker ターゲットを整理（docker/build・docker/down 追加、コンテナ名修正）\n\n整理:\n- dot_tmux.conf の @prefix_highlight_* 重複設定を削除\n- make ci/local を lefthook run pre-push に簡略化（lefthook が single source of truth）\n- completions.zsh の git gtr 補完に command -v ガードを追加\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* docs: README 更新（サンドボックスセクション・Note 文言修正）\n\n- Note 警告文を「サンドボックス環境で試せる」旨のリンクに変更\n- 「動作確認用のDocker環境」→「サンドボックス環境（Docker）」にリネーム\n- Docker セクションを充実化（できること・スキップされる処理を明記）\n- CI セクションの説明から削除済みの「テンプレート変数チェック」を削除\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n---------\n\nCo-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-11T17:15:54+09:00",
          "tree_id": "585b3e8401dec1531955df4f16001f36866ee9d1",
          "url": "https://github.com/taiyo2001/dotfiles/commit/9e9f7e1644d8dc87f70672e84bf1413e14fb7e78"
        },
        "date": 1781165789386,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 60.88,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "100068523+taiyo2001@users.noreply.github.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "8b5bbaa37d7585c3fdf989c5c60b9b238488ebf0",
          "message": "feat: Docker サンドボックス環境を実用レベルに強化 (#17)\n\n- CI=true 環境変数を追加（/.dockerenv 非存在時の brew スキップを保証）\n- run_once_install-packages.sh に CI 検出を追加（/.dockerenv || CI=true）\n- apt ツールを fzf/tmux/bat に絞り込み、bat symlink（batcat→bat）追加\n- chezmoi/starship/direnv/fzf/eza/bat/ghq/peco を mise に統一\n- .git 除外対応: git init -b main で初期コミットを作成（ブランチ表示用）\n- chezmoi apply 後に git config --global でユーザー情報を docker 用に上書き\n- compose.yml に hostname: dotfiles-sandbox を追加\n- WORKDIR を ~/.local/share/chezmoi に変更（git ブランチをプロンプトに表示）\n\nCo-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-11T17:51:09+09:00",
          "tree_id": "911d1c89c6a33a0d6adfb610ab676c7e7e793c90",
          "url": "https://github.com/taiyo2001/dotfiles/commit/8b5bbaa37d7585c3fdf989c5c60b9b238488ebf0"
        },
        "date": 1781167898273,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 40.03,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "100068523+taiyo2001@users.noreply.github.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "e5480a40cb8e5fcd4f8d219930aa6c42544a1315",
          "message": "feat: Sheldon・atuin・zoxide でzsh環境をモダン化 (#19)\n\n* feat: Sheldon・atuin・zoxide でzsh環境をモダン化\n\n- Sheldon（Rust製プラグインマネージャー）を導入し、zsh-autosuggestions・zsh-syntax-highlighting・zsh-history-substring-search をTOML管理に移管\n- Brewfile から zsh-autosuggestions・zsh-syntax-highlighting・z を削除し sheldon・atuin・zoxide・fd を追加\n- atuin を導入し ^R 履歴検索を完全置換（fzf-select-history はコメントアウトして保持）\n- zoxide を導入し z.sh を置き換え\n- fzf 公式キーバインドを有効化（^T: ファイル検索・Alt+C: ディレクトリ移動）\n- FZF_DEFAULT_COMMAND を fd ベースに変更（.gitignore を尊重・高速化）\n- HISTFILE・HISTSIZE・setopt によるhistory設定を強化\n- Completion スタイルを充実（大文字小文字無視・メニュー選択・色付け）\n- fzf-cdr のキーバインドバグを修正（'cdr' → '^f'）\n- brew-upgrade.sh に sheldon lock --update を追加し自動アップグレードに対応\n\nCloses #18\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* docs: README の技術スタック・構成表を更新\n\nSheldon・atuin・zoxide・fd 導入に合わせてツール一覧と構成表を更新。\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* fix: shfmt が解釈できない zsh 固有の list-colors 行を削除\n\n${(s.:.)LS_COLORS} は zsh 固有の parameter expansion で CI の shfmt チェックが失敗するため削除。macOS では LS_COLORS がデフォルト未設定のため実質的な影響なし。\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* docs: 技術スタック表をグループ化・cmux を追加\n\n12行の縦長テーブルを4行のグループ化レイアウトに整理。\n環境管理・シェル・開発環境・Git の4カテゴリに統合し、cmux を開発環境に追加。\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n---------\n\nCo-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-11T23:53:08+09:00",
          "tree_id": "e5f39c9982f0e0f3569adf08c3cfd47e1e3303ef",
          "url": "https://github.com/taiyo2001/dotfiles/commit/e5480a40cb8e5fcd4f8d219930aa6c42544a1315"
        },
        "date": 1781189624290,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 62.38,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "100068523+taiyo2001@users.noreply.github.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "68a5bdff19a7635a55afe2d0c9596ea8fbe57580",
          "message": "feat: atuin インライン表示設定・app/README 整理 (#20)\n\n- atuin を compact スタイル・inline_height=10 に設定しプロンプトを維持したままインライン表示に変更\n- atuin config を chezmoi 管理に追加\n- app/README から Git スニペット項目を削除\n- iTerm2 項目に cmux を使用中である旨の注記を追加\n\nCo-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-12T00:13:43+09:00",
          "tree_id": "e4c6cd6f9f9057ac0cf52c8aef15ddf070260a87",
          "url": "https://github.com/taiyo2001/dotfiles/commit/68a5bdff19a7635a55afe2d0c9596ea8fbe57580"
        },
        "date": 1781190865023,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 49.15,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "100068523+taiyo2001@users.noreply.github.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "a119ffed9f824bc5e27c0276373e5acc549541f7",
          "message": "feat: tpm・tmux プラグインのインストールを自動化 (#21)\n\n* feat: tpm・tmux プラグインのインストールを自動化\n\n- run_once_install-tpm.sh を追加し chezmoi apply 時に tpm クローン・プラグインインストールを自動実行\n- app/README にプレフィックスキー（Ctrl+q）の注記を追加\n- README のセットアップ手順に tpm 自動インストールを追記\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n* docs: 技術スタックに tpm 追加・プレフィックスキー注記を README に移動\n\n- 技術スタック表の開発環境行に tpm を追加\n- tmux プレフィックスキー（Ctrl+q）の注記をテーブル直下に配置\n- app/README から tpm セクションを削除\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>\n\n---------\n\nCo-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-12T00:27:58+09:00",
          "tree_id": "a909c87317724488904fc312b772731810da1a52",
          "url": "https://github.com/taiyo2001/dotfiles/commit/a119ffed9f824bc5e27c0276373e5acc549541f7"
        },
        "date": 1781191708907,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 41.33,
            "unit": "ms"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "taiyo2778@gmail.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "committer": {
            "email": "taiyo2778@gmail.com",
            "name": "taiyo2001",
            "username": "taiyo2001"
          },
          "distinct": true,
          "id": "d0c84f3ceebad27a5550ef757957c497964216f6",
          "message": "docs: アプリ関連の表記を「アプリ設定のインポート」に統一\n\n- 構成テーブルの app/ 行にアンカーリンクを追加\n- 「アプリケーション別セットアップ手順」「アプリケーションごとのセットアップ」「アプリケーションごとのセットアップ項目」を統一\n\nCo-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>",
          "timestamp": "2026-06-12T00:35:47+09:00",
          "tree_id": "9c02c0b92aff3f0819c4aad2ede4ac67050f324a",
          "url": "https://github.com/taiyo2001/dotfiles/commit/d0c84f3ceebad27a5550ef757957c497964216f6"
        },
        "date": 1781192186453,
        "tool": "customSmallerIsBetter",
        "benches": [
          {
            "name": "zsh startup",
            "value": 36.15,
            "unit": "ms"
          }
        ]
      }
    ]
  }
}