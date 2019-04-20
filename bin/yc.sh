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








