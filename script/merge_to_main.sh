#!/bin/bash

# 检查是否提供了分支名称
if [ -z "$1" ]; then
  echo "错误：没有提供要合并的分支名称。"
  echo "用法：$0 分支名称"
  exit 1
fi

# 读取分支名称
branch_name=$1

# 获取当前分支名称
current_branch=$(git branch --show-current)

# 切换到主分支 main
echo "切换到主分支 main..."
git checkout main
if [ $? -ne 0 ]; then
  echo "错误：切换到主分支 main 失败。"
  exit 1
fi

# 拉取远程主分支的最新更改
echo "拉取远程主分支的最新更改..."
git pull origin main
if [ $? -ne 0 ]; then
  echo "错误：拉取远程主分支 main 的最新更改失败。"
  exit 1
fi

# 合并指定分支到主分支
echo "合并分支 $branch_name 到主分支 main..."
git merge $branch_name
if [ $? -ne 0 ]; then
  echo "错误：合并分支 $branch_name 到主分支 main 失败。请解决冲突后再尝试。"
  echo "请解决冲突后运行 'git add <解决冲突的文件>' 来标记解决，之后运行脚本继续操作。"
  exit 1
fi

# 检查是否有未解决的冲突
if git ls-files -u | grep -q "^"; then
  echo "检测到冲突。请解决冲突后继续。"
  echo "解决冲突后，运行以下命令继续合并："
  echo "  git commit"
  echo "  $0 $branch_name"
  exit 1
fi

# 推送主分支到远程仓库
echo "推送主分支 main 到远程仓库..."
git push origin main
if [ $? -ne 0 ]; then
  echo "错误：推送主分支 main 到远程仓库失败。"
  exit 1
fi

echo "成功将分支 $branch_name 合并到主分支 main 并推送到远程仓库。"
