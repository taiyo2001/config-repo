window.BENCHMARK_DATA = {
  "lastUpdate": 1781115233115,
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
      }
    ]
  }
}