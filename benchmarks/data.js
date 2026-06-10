window.BENCHMARK_DATA = {
  "lastUpdate": 1781113856718,
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
      }
    ]
  }
}