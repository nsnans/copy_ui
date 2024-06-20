#!/bin/bash

merge_branch_to_main() {
  local branch_name=$1

  # 切换到主分支 main
  echo "切换到主分支 main..."
  git checkout main || {
    echo "错误：切换到主分支 main 失败。"
    exit 1
  }

  # 拉取远程主分支的最新更改
  echo "拉取远程主分支的最新更改..."
  git pull origin main || {
    echo "错误：拉取远程主分支 main 的最新更改失败。"
    exit 1
  }

  # 尝试合并指定分支到主分支
  echo "合并分支 $branch_name 到主分支 main..."
  git merge $branch_name || {
    if git ls-files -u | grep -q "^"; then
      echo "错误：合并分支 $branch_name 到主分支 main 失败。检测到冲突。"
      echo "请解决冲突后，运行以下命令继续合并："
      echo "  git add <解决冲突的文件>"
      echo "  git commit"
      echo "  $0 $branch_name"
      exit 1
    else
      echo "合并失败，未知错误。"
      exit 1
    fi
  }

  # 检查是否有未解决的冲突
  if git ls-files -u | grep -q "^"; then
    echo "检测到冲突。请解决冲突后继续。"
    echo "解决冲突后，运行以下命令继续合并："
    echo "  git add <解决冲突的文件>"
    echo "  git commit"
    echo "  $0 $branch_name"
    exit 1
  fi

  # 确认是否推送主分支到远程仓库
  read -p "是否要推送主分支 main 到远程仓库 [y/n]? " confirm_push
  if [ "$confirm_push" = "y" ]; then
    echo "推送主分支 main 到远程仓库..."
    git push origin main || {
      echo "错误：推送主分支 main 到远程仓库失败。"
      exit 1
    }
    echo "成功将分支 $branch_name 合并到主分支 main 并推送到远程仓库。"
  else
    echo "取消推送操作。"
  fi
}

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

# 执行合并操作
merge_branch_to_main $branch_name
