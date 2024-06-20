#!/bin/bash

# 设置输出颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# 检查是否提供了提交信息
if [ -z "$1" ]; then
  echo -e "${RED}错误：没有提供提交信息。${NC}"
  echo "用法：$0 \"提交信息\""
  exit 1
fi

# 确认提交操作
echo -e "\n${YELLOW}准备提交更改...${NC}"
echo -e "${YELLOW}提交信息: $1${NC}"
read -p "确认提交？ (y/n): " confirm
if [ "$confirm" != "y" ]; then
  echo -e "${RED}取消提交操作.${NC}"
  exit 0
fi

# 添加所有更改到暂存区
echo -e "\n${GREEN}添加所有更改到暂存区...${NC}"
git add .
if [ $? -ne 0 ]; then
  echo -e "${RED}错误：添加更改到暂存区失败。${NC}"
  exit 1
fi

# 检查是否有更改需要提交
changes=$(git status --porcelain)
if [ -z "$changes" ]; then
  echo -e "${YELLOW}没有检测到更改，不需要提交。${NC}"
  exit 0
fi

# 使用提供的提交信息提交更改
commit_message="$1"
echo -e "\n${GREEN}提交更改到本地仓库...${NC}"
git commit -m "$commit_message"
if [ $? -ne 0 ]; then
  echo -e "${RED}错误：提交更改到本地仓库失败。${NC}"
  exit 1
fi

# 使用 rebase 拉取远程仓库的最新更改
echo -e "\n${YELLOW}拉取远程仓库的最新更改并进行 rebase...${NC}"
git pull --rebase
if [ $? -ne 0 ]; then
  echo -e "${RED}错误：拉取远程仓库的最新更改并进行 rebase 失败。${NC}"
  echo "请解决冲突，然后运行 'git rebase --continue' 完成 rebase。"
  exit 1
fi

# 推送提交的更改到远程仓库
echo -e "\n${GREEN}推送更改到远程仓库...${NC}"
git push
if [ $? -ne 0 ]; then
  echo -e "${RED}错误：推送更改到远程仓库失败。${NC}"
  exit 1
fi

# 提示成功信息
echo -e "\n${GREEN}成功提交并推送更改。${NC}"
echo "提交信息: $commit_message"
echo "推送到分支: $(git branch --show-current)"
