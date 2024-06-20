#!/bin/bash

# 检查参数数量
if [ $# -ne 1 ]; then
  echo "错误：参数数量不正确。"
  echo "用法：$0 分支名称"
  exit 1
fi

# 检查是否提供了分支名称
branch_name=$1

# 显示确认信息
echo "您确定要删除本地分支 '$branch_name' 和远程分支 '$branch_name' 吗？"
read -p "确认删除请输入 [y/n]: " confirm
if [ "$confirm" != "y" ]; then
  echo "取消删除操作。"
  exit 0
fi

# 删除本地分支
echo "正在删除本地分支 $branch_name..."
git branch -D $branch_name
if [ $? -ne 0 ]; then
  echo "错误：删除本地分支 $branch_name 失败。"
  exit 1
fi

# 删除远程分支
echo "正在删除远程分支 $branch_name..."
git push origin --delete $branch_name
if [ $? -ne 0 ]; then
  echo "错误：删除远程分支 $branch_name 失败。"
  echo "请确保分支名称 '$branch_name' 存在并且您有权限删除远程分支。"
  exit 1
fi

echo "成功删除分支 $branch_name 的本地和远程分支。"
