#!/bin/bash
#
# 远程配置的方案
set -euo pipefail

cd $(dirname "$0")
bindir="$(pwd)"
cd -

readonly bindir
rootdir="${bindir%%/yuancheng*}"
readonly rootdir

#### 常量 ####
readonly E_UNRECOGNIZED_OPTION=2

#### 包含 ####

#### 函数 ####
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

#### 变量 ####
readonly oneself="$0"
readonly projectnum="$1"

#### 主体 ####
case "${projectnum}" in
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  )
    bash "${rootdir}"/remote/bin/remote.sh  1,2,3
    ;;
  *)
    err "${oneself##*/}: unrecognized option '${projectnum}'"
    exit "${E_UNRECOGNIZED_OPTION}"
    ;;
esac
