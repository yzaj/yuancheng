#!/bin/bash
#
# 安装远程配置到 yzaj 目录
set -euo pipefail

readonly REPO='remote'
readonly MINTTY='git-bash.exe'
readonly E_USE_MINTTY=1

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

if [[ -f "/d/yzaj/cygwin64/Cygwin-Terminal.ico" ]]; then
  drive='d'
elif [[ -f "/c/yzaj/cygwin64/Cygwin-Terminal.ico" ]]; then
  drive='c'
elif [[ -d "/d" ]]; then
  drive='d'
else
  drive='c'
fi

readonly drive
readonly url="https://github.com/yzaj/${REPO}.git"
readonly repodir="/${drive}/yzaj/${REPO}"
readonly tempdir="/${drive}/yzaj/temp/${REPO}"
readonly bakdir="/${drive}/yzaj/backup/${REPO}"
baktime="$(date +'%Y-%m-%d-%H%M%S')"
readonly baktime

if [[ ! -f "/${MINTTY}" ]]; then
  err "install.sh: please use gitbash to execute"
  exit "${E_USE_MINTTY}"
fi

mkdir -p "${tempdir}"
mkdir -p "${bakdir}"

if [[ -d "${repodir}" ]]; then
  mv "${repodir}" "${bakdir}/${REPO}.bak.${baktime}"
fi

git clone --depth 1 "${url}" "${repodir}"

if [[ -s "${repodir}/bin/install_local.sh" ]]; then
  bash "${repodir}"/bin/install_local.sh "${drive}" 2>&1 | tee "${tempdir}"/install_local.log
fi
