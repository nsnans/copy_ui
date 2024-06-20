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
git checkout -b $branch_name
if [ $? -ne 0 ]; then
  echo "错误：创建或切换到分支 $branch_name 失败。"
  exit 1
fi

# 添加所有更改到暂存区
git add .

# 使用提供的提交信息提交更改
git commit -m "$commit_message"
if [ $? -ne 0 ]; then
  echo "错误：提交更改失败。"
  exit 1
fi

# 将新分支推送到远程仓库
git push -u origin $branch_name
if [ $? -ne 0 ]; then
  echo "错误：将分支 $branch_name 推送到远程仓库失败。"
  exit 1
fi

echo "成功创建并推送分支 $branch_name 到远程仓库。"
