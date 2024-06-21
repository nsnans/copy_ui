#!/bin/bash

# ANSI颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # 恢复默认颜色

# 获取本地分支列表
branches=$(git branch --list --no-color | sed 's/^\*//')

# 检查是否有本地分支可供选择
if [ -z "$branches" ]; then
  echo -e "${RED}没有找到任何本地分支。${NC}"
  exit 1
fi

# 显示可供选择的分支列表
echo -e "${YELLOW}请选择要删除的分支：${NC}"
select branch_name in $branches; do
  if [ -n "$branch_name" ]; then
    break
  else
    echo -e "${RED}错误：无效的选择。请重新选择。${NC}"
  fi
done

# 显示确认信息
echo -e "您确定要删除本地分支 '${YELLOW}$branch_name${NC}' 和远程分支 '${YELLOW}$branch_name${NC}' 吗？"
read -p "确认删除请输入 [y/n]: " confirm
if [ "$confirm" != "y" ]; then
  echo -e "${YELLOW}取消删除操作。${NC}"
  exit 0
fi

# 删除本地分支
echo -e "正在删除本地分支 ${YELLOW}$branch_name${NC}..."
git branch -D $branch_name
if [ $? -ne 0 ]; then
  echo -e "${RED}错误：删除本地分支 $branch_name 失败。${NC}"
  exit 1
fi

# 删除远程分支
echo -e "正在删除远程分支 ${YELLOW}$branch_name${NC}..."
git push origin --delete $branch_name
if [ $? -ne 0 ]; then
  echo -e "${RED}错误：删除远程分支 $branch_name 失败。${NC}"
  echo -e "${RED}请确保分支名称 '${YELLOW}$branch_name${NC}' 存在并且您有权限删除远程分支。${NC}"
  exit 1
fi

echo -e "${GREEN}成功删除分支 $branch_name 的本地和远程分支。${NC}"
