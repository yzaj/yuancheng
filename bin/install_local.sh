#!/bin/bash
#
# 安装远程配置的方案
set -euo pipefail

#### 常量 ####
readonly E_NOT_FOUND=127

#### 包含 ####

#### 函数 ####
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

#### 变量 ####
readonly oneself="$0"
readonly drive="$1"
readonly rootdir="/${drive}/yzaj"
readonly reposrc="${rootdir}/remote/bin/remote.sh"
username="$(whoami)"
readonly username

#### 主体 ####
if [[ ! -s "${reposrc}" ]]; then
  err "${oneself##*/}: remote.sh not found"
  exit "${E_NOT_FOUND}"
fi













