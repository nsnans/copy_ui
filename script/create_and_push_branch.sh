#!/bin/bash

# ANSI颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # 恢复默认颜色

# 检查是否提供了分支名称和提交信息
if [ -z "$1" ] || [ -z "$2" ]; then
  echo -e "${RED}错误：没有提供分支名称或提交信息。${NC}"
  echo "用法：$0 分支名称 \"提交信息\""
  exit 1
fi

# 读取分支名称和提交信息
branch_name=$1
commit_message=$2

# 创建新分支并切换到该分支
echo -e "${YELLOW}创建并切换到分支 $branch_name...${NC}"
git checkout -b $branch_name
if [ $? -ne 0 ]; then
  echo -e "${RED}错误：创建或切换到分支 $branch_name 失败。${NC}"
  exit 1
fi

# 检查是否有更改需要提交
if git status --porcelain | grep -q "^\s*[MADRC]"; then
  # 添加所有更改到暂存区
  echo -e "${YELLOW}添加所有更改到暂存区...${NC}"
  git add -A

  # 使用提供的提交信息提交更改
  echo -e "${YELLOW}提交更改到本地仓库...${NC}"
  git commit -m "$commit_message"
  if [ $? -ne 0 ]; then
    echo -e "${RED}错误：提交更改失败。${NC}"
    exit 1
  fi
else
  echo -e "${GREEN}没有检测到更改，不需要提交。${NC}"
fi

# 将新分支推送到远程仓库
echo -e "${YELLOW}推送分支 $branch_name 到远程仓库...${NC}"
git push -u origin $branch_name
if [ $? -ne 0 ]; then
  echo -e "${RED}警告：将分支 $branch_name 推送到远程仓库失败。可能是因为分支已存在。${NC}"
  read -p "${YELLOW}是否尝试强制推送分支 $branch_name [y/n]? ${NC}" force_push
  if [ "$force_push" = "y" ]; then
    git push -u --force origin $branch_name
    if [ $? -ne 0 ]; then
      echo -e "${RED}错误：强制推送分支 $branch_name 失败。${NC}"
      exit 1
    fi
  else
    echo -e "${RED}取消推送操作。${NC}"
    exit 1
  fi
fi

echo -e "${GREEN}成功创建并推送分支 $branch_name 到远程仓库。${NC}"
