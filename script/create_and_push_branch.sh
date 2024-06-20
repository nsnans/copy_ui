#!/bin/bash

# 检查是否提供了分支名称和提交信息
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "错误：没有提供分支名称或提交信息。"
  echo "用法：$0 分支名称 \"提交信息\""
  exit 1
fi

# 读取分支名称和提交信息
branch_name=$1
commit_message=$2

# 创建新分支并切换到该分支
echo "创建并切换到分支 $branch_name..."
git checkout -b $branch_name
if [ $? -ne 0 ]; then
  echo "错误：创建或切换到分支 $branch_name 失败。"
  exit 1
fi

# 检查是否有更改需要提交
if git status --porcelain | grep -q "^\s*[MADRC]"; then
  # 添加所有更改到暂存区
  echo "添加所有更改到暂存区..."
  git add -A

  # 使用提供的提交信息提交更改
  echo "提交更改到本地仓库..."
  git commit -m "$commit_message"
  if [ $? -ne 0 ]; then
    echo "错误：提交更改失败。"
    exit 1
  fi
else
  echo "没有检测到更改，不需要提交。"
fi

# 将新分支推送到远程仓库
echo "推送分支 $branch_name 到远程仓库..."
git push -u origin $branch_name
if [ $? -ne 0 ]; then
  echo "警告：将分支 $branch_name 推送到远程仓库失败。可能是因为分支已存在。"
  read -p "是否尝试强制推送分支 $branch_name [y/n]? " force_push
  if [ "$force_push" = "y" ]; then
    git push -u --force origin $branch_name
    if [ $? -ne 0 ]; then
      echo "错误：强制推送分支 $branch_name 失败。"
      exit 1
    fi
  else
    echo "取消推送操作。"
    exit 1
  fi
fi

echo "成功创建并推送分支 $branch_name 到远程仓库。"
