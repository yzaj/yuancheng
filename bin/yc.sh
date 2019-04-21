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
readonly YDAY_COLOR_NO=37
readonly TODAY_COLOR_NO=31
readonly TODAY_COLOR_YES=37
readonly TODAY_COLOR_LAST=37
readonly READMAX=10
readonly E_OPERATION_FAILED=3

#### 包含 ####
. "${rootdir}"/shell/lib/filedir.sh
. "${rootdir}"/shell/lib/color.sh

#### 函数 ####
# 功  能: 同 echo, 不换行, 不高亮
# 使  用: echoline 输出内容 颜色值
# 参数 1: 输出内容    [default: ]
# 参数 2: 颜色值    [default: ]
# 返回值: 输出内容
# 备  注: 
echoline() {
  local message="$1"
  local color="$2"
  
  echo -ne "\e[0m\e[40;${color}m${message}\e[0m"
}

#### 变量 ####
qq_list='3-1,3-2,4-1,4-2,5-1,5-2,6-1,6-2,7-1,7-2'
space=''
result=0

readonly confdir="${rootdir}/remote/conf"
readonly taskdir="${rootdir}/temp/remote/task"
readonly yctmp="${rootdir}/temp/yuancheng/yc.tmp"

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

# 菜单的第一部分
cat <<-'EOF'
昨天未做:

EOF

touch "${ydaytask}"

for qq in ${QQS}; do
  if echo "${qq_list}" | grep ",${qq}," &> /dev/null; then
    
    if [[ "${qq}" =~ ^[1-9]-[1-2]$ ]]; then
      space=' '
    fi
    
    if ! grep "^${qq} 3" "${ydaytask}" &> /dev/null; then
      echoline "                                                    第三批\r" "${YDAY_COLOR_NO}"
      result=1
    fi
    
    if ! grep "^${qq} 2" "${ydaytask}" &> /dev/null; then
      echoline "                               第二批\r" "${YDAY_COLOR_NO}"
      result=1
    fi
    
    if ! grep "^${qq} 1" "${ydaytask}" &> /dev/null; then
      echoline "          第一批\r" "${YDAY_COLOR_NO}"
      result=1
    fi
    
    if [[ "${result}" == "1" ]]; then
      echo "${space}${qq}"
    fi
    
    space=''
    result=0
    
  fi
done

# 菜单的第二部分
cat <<-'EOF'


今天任务:

EOF

touch "${todaytask}"

lasttime="$(tail -n 1 "${todaytask}" | cut -d' ' -f 3)"
readonly lasttime

for qq in ${QQS}; do
  if echo "${qq_list}" | grep ",${qq}," &> /dev/null; then
    
    if [[ "${qq}" =~ ^[1-9]-[1-2]$ ]]; then
      space=' '
    fi
    
    if grep "^${qq} 3" "${todaytask}" | cut -d' ' -f 3 > "${yctmp}"; then
      
      if [[ "${lasttime}" == "$(cat "${yctmp}")" ]]; then
        echoline "                                                  > 第三批 $(cat "${yctmp}")\r" "${TODAY_COLOR_LAST}"
      else
        echoline "                                                    第三批 $(cat "${yctmp}")\r" "${TODAY_COLOR_YES}"
      fi
      
    else
      echoline "                                                    第三批\r" "${TODAY_COLOR_NO}"
    fi
    
    if grep "^${qq} 2" "${todaytask}" | cut -d' ' -f 3 > "${yctmp}"; then
      
      if [[ "${lasttime}" == "$(cat "${yctmp}")" ]]; then
        echoline "                             > 第二批 $(cat "${yctmp}")\r" "${TODAY_COLOR_LAST}"
      else
        echoline "                               第二批 $(cat "${yctmp}")\r" "${TODAY_COLOR_YES}"
      fi
      
    else
      echoline "                               第二批\r" "${TODAY_COLOR_NO}"
    fi
    
    if grep "^${qq} 1" "${todaytask}" | cut -d' ' -f 3 > "${yctmp}"; then
      
      if [[ "${lasttime}" == "$(cat "${yctmp}")" ]]; then
        echoline "        > 第一批 $(cat "${yctmp}")\r" "${TODAY_COLOR_LAST}"
      else
        echoline "          第一批 $(cat "${yctmp}")\r" "${TODAY_COLOR_YES}"
      fi
      
    else
      echoline "          第一批\r" "${TODAY_COLOR_NO}"
    fi
    
    echo "${space}${qq}"
    
    space=''
    
  fi
done

# 菜单的第三部分
cat <<-'EOF'


远程配置:

   0      全部

  31       3-1
  32       3-2
  41       4-1
  42       4-2
  51       5-1
  52       5-2
  61       6-1
  62       6-2
  71       7-1
  72       7-2


EOF

# 输入
nums="$(seq "${READMAX}")"
readonly nums

for num in ${nums}; do
  color::read '请输入编号: ' 35 'projectnum'
  echo ''
  
  if [[ "${projectnum}" =~ ^[0-9]{1,}$ ]]; then
    break
  fi
  
  if [[ "${num}" == "${READMAX}" ]]; then
    color::echo '错误: 超出可输入次数, 程序已中止' 31
    exit "${E_OPERATION_FAILED}"
  fi
done

readonly projectnum

# 执行
color::countdown 5 35 '程序将在 ' 34 ' 秒后自动执行, 请停止操作' 34

bash "${bindir}"/yuancheng.sh "${projectnum}"

echo ''
color::timer 34 '已完成! 耗时: ' 32
