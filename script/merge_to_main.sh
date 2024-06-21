#!/bin/bash

# ANSI颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # 恢复默认颜色

merge_branch_to_main() {
  local branch_name=$1
  local merge_type=$2

  # 切换到主分支 main
  echo -e "${YELLOW}切换到主分支 main...${NC}"
  git checkout main || {
    echo -e "${RED}错误：切换到主分支 main 失败。${NC}"
    exit 1
  }

  # 拉取远程主分支的最新更改
  echo -e "${YELLOW}拉取远程主分支的最新更改...${NC}"
  git pull origin main || {
    echo -e "${RED}错误：拉取远程主分支 main 的最新更改失败。${NC}"
    exit 1
  }

  # 根据用户选择的合并方式进行合并
  if [ "$merge_type" = "squash" ]; then
    echo -e "${YELLOW}以 squash 方式合并分支 $branch_name 到主分支 main...${NC}"
    git merge --squash $branch_name || {
      echo -e "${RED}错误：合并分支 $branch_name 到主分支 main 失败。${NC}"
      exit 1
    }
    echo -e "${YELLOW}请编辑合并提交信息并提交：${NC}"
    git commit  # 允许用户编辑提交信息
  else
    echo -e "${YELLOW}合并分支 $branch_name 到主分支 main...${NC}"
    git merge $branch_name || {
      if git ls-files -u | grep -q "^"; then
        echo -e "${RED}错误：合并分支 $branch_name 到主分支 main 失败。检测到冲突。${NC}"
        echo -e "${YELLOW}请解决冲突后，运行以下命令继续合并：${NC}"
        echo -e "${YELLOW}  git add <解决冲突的文件>${NC}"
        echo -e "${YELLOW}  git commit${NC}"
        echo -e "${YELLOW}  $0 $branch_name $merge_type${NC}"
        exit 1
      else
        echo -e "${RED}合并失败，未知错误。${NC}"
        exit 1
      fi
    }
  fi

  # 检查是否有未解决的冲突
  if git ls-files -u | grep -q "^"; then
    echo -e "${RED}检测到冲突。请解决冲突后继续。${NC}"
    echo -e "${YELLOW}解决冲突后，运行以下命令继续合并：${NC}"
    echo -e "${YELLOW}  git add <解决冲突的文件>${NC}"
    echo -e "${YELLOW}  git commit${NC}"
    echo -e "${YELLOW}  $0 $branch_name $merge_type${NC}"
    exit 1
  fi

  # 确认是否推送主分支到远程仓库
  read -rp "${YELLOW}是否要推送主分支 main 到远程仓库 [y/n]? ${NC}" confirm_push
  confirm_push=${confirm_push:-y}  # 如果用户直接按 Enter，默认为 y
  if [ "$confirm_push" = "y" ]; then
    echo -e "${YELLOW}推送主分支 main 到远程仓库...${NC}"
    git push origin main || {
      echo -e "${RED}错误：推送主分支 main 到远程仓库失败。${NC}"
      exit 1
    }
    echo -e "${GREEN}成功将分支 $branch_name 合并到主分支 main 并推送到远程仓库。${NC}"
  else
    echo -e "${YELLOW}取消推送操作。${NC}"
  fi
}

# 获取本地分支列表
branches=$(git branch --list --no-color | sed 's/^\*//')

# 检查是否有本地分支可供选择
if [ -z "$branches" ]; then
  echo -e "${RED}错误：没有找到任何本地分支。请先创建分支。${NC}"
  exit 1
fi

# 交互式选择要合并的分支
echo -e "${YELLOW}请选择要合并到主分支 main 的分支：${NC}"
select branch_name in $branches; do
  if [ -n "$branch_name" ]; then
    break
  else
    echo -e "${RED}错误：无效的选择。请重新选择。${NC}"
  fi
done

# 询问用户选择合并方式
echo -e "${YELLOW}请选择合并方式：${NC}"
echo -e "1) 合并成一个提交 (squash merge)"
echo -e "2) 保留多个提交 (regular merge)"
read -rp "${YELLOW}输入选项 [1/2]: ${NC}" merge_option

if [ "$merge_option" = "1" ]; then
  merge_type="squash"
elif [ "$merge_option" = "2" ]; then
  merge_type="regular"
else
  echo -e "${RED}错误：无效的选项。${NC}"
  exit 1
fi

# 执行合并操作
merge_branch_to_main "$branch_name" "$merge_type"
