#!/usr/bin/env bash
set -euo pipefail
DEST="${1:-physiotherapy-pocket-handbook-site}"
KIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v git >/dev/null; then echo "git tidak ditemukan"; exit 1; fi
if ! command -v node >/dev/null; then echo "Node.js >=22 diperlukan"; exit 1; fi
if ! command -v npm >/dev/null; then echo "npm >=10.9.2 diperlukan"; exit 1; fi

NODE_MAJOR=$(node -p 'process.versions.node.split(".")[0]')
if [ "$NODE_MAJOR" -lt 22 ]; then echo "Node.js >=22 diperlukan. Saat ini: $(node -v)"; exit 1; fi

if [ -e "$DEST" ]; then echo "Destination sudah ada: $DEST"; exit 1; fi

echo "Cloning Quartz v5..."
git clone --depth 1 --branch v5 https://github.com/jackyzha0/quartz.git "$DEST"
rm -rf "$DEST/.git"
rm -rf "$DEST/content"
mkdir -p "$DEST/content"
cp -a "$KIT_ROOT/content/." "$DEST/content/"
cp "$KIT_ROOT/quartz.config.yaml" "$DEST/quartz.config.yaml"
cp "$KIT_ROOT/README.md" "$DEST/README.md"
cp "$KIT_ROOT/CONTRIBUTING.md" "$DEST/CONTRIBUTING.md"
cp "$KIT_ROOT/STYLE_GUIDE.md" "$DEST/STYLE_GUIDE.md"
cp "$KIT_ROOT/PRIVACY_AND_CONTENT_POLICY.md" "$DEST/PRIVACY_AND_CONTENT_POLICY.md"
cp "$KIT_ROOT/PUBLICATION_CHECKLIST.md" "$DEST/PUBLICATION_CHECKLIST.md"
cp "$KIT_ROOT/LICENSE-CONTENT.md" "$DEST/LICENSE-CONTENT.md"
cp "$KIT_ROOT/LICENSE-CODE" "$DEST/LICENSE-CODE"
cp "$KIT_ROOT/CODE_OF_CONDUCT.md" "$DEST/CODE_OF_CONDUCT.md"
cp "$KIT_ROOT/CITATION.cff" "$DEST/CITATION.cff"
cp "$KIT_ROOT/.gitignore" "$DEST/.gitignore"
cp "$KIT_ROOT/.gitattributes" "$DEST/.gitattributes"
cp -a "$KIT_ROOT/.github" "$DEST/.github"
cp -a "$KIT_ROOT/templates" "$DEST/templates"
cp -a "$KIT_ROOT/scripts" "$DEST/scripts"
cp "$KIT_ROOT/DEPLOY_CLOUDFLARE.md" "$DEST/DEPLOY_CLOUDFLARE.md"
cp "$KIT_ROOT/DEPLOY_GITHUB_PAGES.md" "$DEST/DEPLOY_GITHUB_PAGES.md"
chmod +x "$DEST/scripts/bootstrap-quartz5.sh" || true

cd "$DEST"
python3 scripts/prepublish_check.py content
npm ci
npx quartz plugin install --from-config
npx quartz build

git init -b main

echo
echo "Selesai. Edit quartz.config.yaml -> baseUrl, lalu:"
echo "  cd $DEST"
echo "  git add . && git commit -m 'Initial publication'"
echo "  git remote add origin <URL_REPO_GITHUB>"
echo "  git push -u origin main"
