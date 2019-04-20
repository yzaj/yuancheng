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

#### 主体 ####
# 读取配置文件
filedir::config "qq_list" "[1-9][0-9,-]*[1-2,]" "${confdir}/remote.conf"
qq_list=",${qq_list},"

readonly qq_list





