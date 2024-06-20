#!/bin/bash

# 检查是否提供了提交信息
if [ -z "$1" ]; then
  echo "错误：没有提供提交信息。"
  echo "用法：$0 \"提交信息\""
  exit 1
fi

# 添加所有更改到暂存区
echo "添加所有更改到暂存区..."
git add .
if [ $? -ne 0 ]; then
  echo "错误：添加更改到暂存区失败。"
  exit 1
fi

# 使用提供的提交信息提交更改
commit_message="$1"
echo "提交更改到本地仓库..."
git commit -m "$commit_message"
if [ $? -ne 0 ]; then
  echo "错误：提交更改到本地仓库失败。"
  exit 1
fi

# 使用 rebase 拉取远程仓库的最新更改
echo "拉取远程仓库的最新更改并进行 rebase..."
git pull --rebase
if [ $? -ne 0 ]; then
  echo "错误：拉取远程仓库的最新更改并进行 rebase 失败。"
  echo "请解决冲突，然后运行 'git rebase --continue' 完成 rebase。"
  exit 1
fi

# 推送提交的更改到远程仓库
echo "推送更改到远程仓库..."
git push
if [ $? -ne 0 ]; then
  echo "错误：推送更改到远程仓库失败。"
  exit 1
fi

echo "成功提交并推送更改。"
