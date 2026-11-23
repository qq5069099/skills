#!/usr/bin/env bash
# 把仓库根目录下每个含 SKILL.md 的子文件夹链接到 ~/.claude/skills
# 用法：bash install.sh
set -e
repo="$(cd "$(dirname "$0")" && pwd)"
dest="$HOME/.claude/skills"
mkdir -p "$dest"

for d in "$repo"/*/; do
  [ -f "${d}SKILL.md" ] || continue
  name="$(basename "$d")"
  link="$dest/$name"
  if [ -L "$link" ]; then
    rm "$link"
  elif [ -e "$link" ]; then
    echo "跳过：已存在非链接目录 $link"
    continue
  fi
  ln -s "${d%/}" "$link"
  echo "已链接：$name -> ${d%/}"
done
echo "完成。技能目录：$dest"
