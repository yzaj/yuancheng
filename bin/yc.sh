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

#### 包含 ####
. "${rootdir}"/shell/lib/filedir.sh

#### 函数 ####

#### 变量 ####
qq_list='3-1,3-2,4-1,4-2,5-1,5-2,6-1,6-2,7-1,7-2'

readonly confdir="${rootdir}/remote/conf"
readonly taskdir="${rootdir}/temp/remote/task"

todaytask="${taskdir}/$(date +'%Y-%m-%d').task"
ydaytask="${taskdir}/$(date +'%Y-%m-%d' -d '-1day').task"

readonly todaytask
readonly ydaytask

#### 主体 ####
# 读取配置文件
filedir::config "qq_list" "[1-9][0-9,-]*[1-2,]" "${confdir}/remote.conf"
qq_list=",${qq_list},"

readonly qq_list

clear

# 5-1
cat <<-'EOF'
昨天未做:
EOF

if [[ -s "${ydaytask}" ]]; then
  
  :
  
fi

# 5-2
cat <<-'EOF'


今天任务:
EOF

if [[ -s "${todaytask}" ]]; then
  
  :
  
fi

# 5-3
cat <<-'EOF'


当前任务:
EOF

# 5-4
cat <<-'EOF'


远程配置:

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

# 5-5


