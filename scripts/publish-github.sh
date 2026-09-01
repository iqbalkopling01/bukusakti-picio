#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="${1:-physiotherapy-pocket-handbook}"
VISIBILITY="${2:-public}"
DESCRIPTION="Open physiotherapy pocket handbook: integrated study notes from basic science to clinical reasoning"

if ! command -v gh >/dev/null; then
  echo "GitHub CLI (gh) belum terpasang. Install dari https://cli.github.com/ lalu jalankan gh auth login."
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "GitHub CLI belum login. Jalankan: gh auth login"
  exit 1
fi

if [ ! -d .git ]; then
  git init -b main
fi

python scripts/prepublish_check.py content
python scripts/wikilink_report.py content

git add .
if ! git diff --cached --quiet; then
  git commit -m "Initial public handbook release"
fi

if gh repo view "$REPO_NAME" >/dev/null 2>&1; then
  echo "Repository $REPO_NAME sudah ada. Menggunakan repository tersebut."
  if ! git remote get-url origin >/dev/null 2>&1; then
    OWNER=$(gh api user -q .login)
    git remote add origin "https://github.com/${OWNER}/${REPO_NAME}.git"
  fi
else
  gh repo create "$REPO_NAME" --"$VISIBILITY" --description "$DESCRIPTION" --source=. --remote=origin
fi

git push -u origin main

echo
echo "Repo sudah dipush."
echo "Untuk GitHub Pages: buka Settings → Pages → Source: GitHub Actions."
echo "Lalu edit baseUrl di quartz.config.yaml dan push lagi."
