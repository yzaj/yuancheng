#!/bin/bash
#
# 远程配置的交互
set -euo pipefail

cd $(dirname "$0")
bindir="$(pwd)"
cd -

readonly bindir
rootdir="${bindir%%/yuancheng*}"
readonly rootdir

#### 常量 ####
readonly QQS='1-1 1-2 2-1 2-2 3-1 3-2 4-1 4-2 5-1 5-2 6-1 6-2 7-1 7-2 8-1 8-2 9-1 9-2 10-1 10-2'
readonly BATS='3 2 1'

#### 包含 ####
. "${rootdir}"/shell/lib/filedir.sh

#### 函数 ####

#### 变量 ####
qq_list='3-1,3-2,4-1,4-2,5-1,5-2,6-1,6-2,7-1,7-2'
readonly confdir="${rootdir}/remote/conf"
readonly taskdir="${rootdir}/temp/remote/task"
todaytask="${taskdir}/$(date +'%Y-%m-%d').task"
ydaytask="${taskdir}/$(date +'%Y-%m-%d' -d '-1day').task"
result=0
readonly todaytask
readonly ydaytask

#### 主体 ####
# 读取配置文件
filedir::config "qq_list" "[1-9][0-9,-]*[1-2,]" "${confdir}/remote.conf"
qq_list=",${qq_list},"

readonly qq_list

# 菜单1: 头部
clear

cat <<-'EOF'
正在远程配置:


EOF

# 菜单2: 昨天
echo "昨天任务:"

if [[ -s "${ydaytask}" ]]; then
  for qq in ${QQS}; do
    if echo "${qq_list}" | grep ",${qq}," &> /dev/null; then
      
      for bat in ${BATS}; do
        if ! grep "^${qq} ${bat}" "${ydaytask}" &> /dev/null; then
          if [[ "${bat}" == "1" ]]; then
            echo -ne "     ${bat}\r"
          elif [[ "${bat}" == "2" ]]; then
            echo -ne "       ${bat}\r"
          else
            echo -ne "         ${bat}\r"
          fi
          
          result=1
        fi
      done
      
      if [[ "${result}" == "1" ]]; then
        echo "${qq}"
        result=0
      fi
      
    fi
  done
fi





echo ""
echo ""

# 菜单3: 今天
echo "今天任务:"







echo ""
echo ""

# 菜单4: 当前
echo "当前任务:"



















# 菜单5: 编号
cat <<-'EOF'


操作列表:

 0    全部

 5    3-1
 6    3-2
 7    4-1
 8    4-2
 9    5-1

10    5-2
11    6-1
12    6-2
13    7-1
14    7-2


EOF

# 菜单6: 输入







































