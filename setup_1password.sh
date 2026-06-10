#!/usr/bin/env bash
set -euo pipefail

VAULT="Private"
ITEM="dotfiles"

echo "1Password に '${VAULT}/${ITEM}' アイテムをセットアップします"
echo ""

if op item get "${ITEM}" --vault "${VAULT}" &>/dev/null; then
  echo "アイテム '${ITEM}' は既に存在します。上書きしますか？ [y/N]"
  read -r answer
  if [[ "${answer}" != "y" && "${answer}" != "Y" ]]; then
    echo "キャンセルしました"
    exit 0
  fi
  op item delete "${ITEM}" --vault "${VAULT}"
fi

read -rp "git config email: " git_email
read -rp "git config signingkey (GPG key ID): " git_signingkey
read -rsp "claude code org_uuid: " claude_org_uuid
echo ""

op item create \
  --category "Secure Note" \
  --title "${ITEM}" \
  --vault "${VAULT}" \
  "git config email[text]=${git_email}" \
  "git config signingkey[text]=${git_signingkey}" \
  "claude code org_uuid[password]=${claude_org_uuid}"

echo "✓ '${VAULT}/${ITEM}' アイテムを作成しました"
