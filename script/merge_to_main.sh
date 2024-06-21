#!/bin/bash

merge_branch_to_main() {
  local branch_name=$1
  local merge_type=$2

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

  # 根据用户选择的合并方式进行合并
  if [ "$merge_type" = "squash" ]; then
    echo "以 squash 方式合并分支 $branch_name 到主分支 main..."
    git merge --squash $branch_name || {
      echo "错误：合并分支 $branch_name 到主分支 main 失败。"
      exit 1
    }
    echo "请编辑合并提交信息并提交（输入 EOF 结束输入）："
    git commit || {
      echo "错误：提交失败。"
      exit 1
    }
  else
    echo "合并分支 $branch_name 到主分支 main..."
    git merge $branch_name || {
      if git ls-files -u | grep -q "^"; then
        echo "错误：合并分支 $branch_name 到主分支 main 失败。检测到冲突。"
        echo "请解决冲突后，运行以下命令继续合并："
        echo "  git add <解决冲突的文件>"
        echo "  git commit"
        echo "  $0 $branch_name $merge_type"
        exit 1
      else
        echo "合并失败，未知错误。"
        exit 1
      fi
    }
  fi

  # 检查是否有未解决的冲突
  if git ls-files -u | grep -q "^"; then
    echo "检测到冲突。请解决冲突后继续。"
    echo "解决冲突后，运行以下命令继续合并："
    echo "  git add <解决冲突的文件>"
    echo "  git commit"
    echo "  $0 $branch_name $merge_type"
    exit 1
  fi

  # 确认是否推送主分支到远程仓库
  read -rp "是否要推送主分支 main 到远程仓库 [y/n]? " confirm_push
  confirm_push=${confirm_push:-y}  # 如果用户直接按 Enter，默认为 y
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

# 获取本地分支列表
branches=$(git branch --list --no-color | sed 's/^\*//')

# 检查是否有本地分支可供选择
if [ -z "$branches" ]; then
  echo "错误：没有找到任何本地分支。请先创建分支。"
  exit 1
fi

# 交互式选择要合并的分支
echo "请选择要合并到主分支 main 的分支："
select branch_name in $branches; do
  if [ -n "$branch_name" ]; then
    break
  else
    echo "错误：无效的选择。请重新选择。"
  fi
done

# 询问用户选择合并方式
echo "请选择合并方式："
echo "1) 合并成一个提交 (squash merge)"
echo "2) 保留多个提交 (regular merge)"
read -rp "输入选项 [1/2]: " merge_option

if [ "$merge_option" = "1" ]; then
  merge_type="squash"
elif [ "$merge_option" = "2" ]; then
  merge_type="regular"
else
  echo "错误：无效的选项。"
  exit 1
fi

# 执行合并操作
merge_branch_to_main "$branch_name" "$merge_type"
