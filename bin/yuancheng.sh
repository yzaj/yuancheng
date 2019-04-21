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
  0 | all)
    bash "${rootdir}"/remote/bin/remote.sh all 1,2,3
    ;;
  31 | 3-1)
    bash "${rootdir}"/remote/bin/remote.sh 3-1 1,2,3
    ;;
  32 | 3-2)
    bash "${rootdir}"/remote/bin/remote.sh 3-2 1,2,3
    ;;
  41 | 4-1)
    bash "${rootdir}"/remote/bin/remote.sh 4-1 1,2,3
    ;;
  42 | 4-2)
    bash "${rootdir}"/remote/bin/remote.sh 4-2 1,2,3
    ;;
  51 | 5-1)
    bash "${rootdir}"/remote/bin/remote.sh 5-1 1,2,3
    ;;
  52 | 5-2)
    bash "${rootdir}"/remote/bin/remote.sh 5-2 1,2,3
    ;;
  61 | 6-1)
    bash "${rootdir}"/remote/bin/remote.sh 6-1 1,2,3
    ;;
  62 | 6-2)
    bash "${rootdir}"/remote/bin/remote.sh 6-2 1,2,3
    ;;
  71 | 7-1)
    bash "${rootdir}"/remote/bin/remote.sh 7-1 1,2,3
    ;;
  72 | 7-2)
    bash "${rootdir}"/remote/bin/remote.sh 7-2 1,2,3
    ;;
  *)
    err "${oneself##*/}: unrecognized option '${projectnum}'"
    exit "${E_UNRECOGNIZED_OPTION}"
    ;;
esac
