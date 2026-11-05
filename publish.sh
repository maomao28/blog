#!/bin/sh
# 毛毛博客 一键发布（2026-11-05）
# 用法：./publish.sh            # 生成并发布
#      ./publish.sh --draft    # 只生成，本地预览用（不发布）
#
# 令牌来源（按优先级）：
#   1. 环境变量 CLOUDFLARE_API_TOKEN
#   2. ~/.cf-blog-token 文件（chmod 600，内容就是 cfat_ 开头的令牌）
#
# 为什么必须用 wrangler 而不是 REST API：
#   直接调 POST /pages/projects/blog/deployments 上传文件，接口返回 success，
#   但所有资源一律 500 —— 文件根本没登记进资产库。wrangler 内部会走
#   check-missing → upload → upsert-hashes 完整流程，才会真正生效。

set -e
cd "$(dirname "$0")"

echo "==> 清理旧产物"
npx hexo clean

echo "==> 生成静态文件"
npx hexo generate

if [ "$1" = "--draft" ]; then
  echo "==> 仅生成完成，产物在 ./public"
  echo "    本地预览：npx hexo server"
  exit 0
fi

TOKEN="${CLOUDFLARE_API_TOKEN:-}"
if [ -z "$TOKEN" ] && [ -f "$HOME/.cf-blog-token" ]; then
  TOKEN=$(cat "$HOME/.cf-blog-token")
fi
if [ -z "$TOKEN" ]; then
  echo "✘ 找不到 Cloudflare 令牌。"
  echo "  要么 export CLOUDFLARE_API_TOKEN=xxx"
  echo "  要么把令牌写进 ~/.cf-blog-token 并 chmod 600"
  exit 1
fi

echo "==> 发布到 Cloudflare Pages（项目 blog，分支 main）"
CLOUDFLARE_API_TOKEN="$TOKEN" npx wrangler pages deploy public \
  --project-name=blog --branch=main --commit-dirty=true

echo "==> 同步源码到 GitHub"
git add -A
if git diff --cached --quiet; then
  echo "    （源码无变化，跳过提交）"
else
  git commit -m "post: $(date '+%Y-%m-%d %H:%M') 更新博客"
fi
git push origin main

echo "✅ 完成。线上地址：https://www.mmhh.life"
