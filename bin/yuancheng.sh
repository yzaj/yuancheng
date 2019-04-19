#!/bin/bash
#
# 远程配置
set -euo pipefail

cd $(dirname "$0")
bindir="$(pwd)"
cd -

readonly bindir
rootdir="${bindir%%/remote*}"
readonly rootdir

#### 包含 ####
. "${bindir}"/remotevar.sh
. "${rootdir}"/shell/lib/filedir.sh

#### 函数 ####
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

#### 变量 ####

#### 主体 ####
# 读取配置文件
filedir::config "qq_list" "[1-9][0-9,-]*[1-2,]" "${confdir}/remote.conf"
qq_list=",${qq_list},"

readonly qq_list

# 创建 log
. "${bindir}"/remotemain.sh 2>&1 | tee "${tempdir}"/remote.log
