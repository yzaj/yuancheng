#!/bin/bash
#
# 安装远程配置
set -euo pipefail

#### 常量 ####
readonly CON_DIRS='master-all master-batch
                   slave-1-1  slave-1-2
                   slave-2-1  slave-2-2
                   slave-3-1  slave-3-2
                   slave-4-1  slave-4-2
                   slave-5-1  slave-5-2
                   slave-6-1  slave-6-2
                   slave-7-1  slave-7-2
                   slave-8-1  slave-8-2
                   slave-9-1  slave-9-2
                   slave-10-1 slave-10-2
                   upload'
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
readonly repores="${rootdir}/remote-resource/resource"
readonly resdir="${rootdir}/remote/resource"
readonly bindir="${rootdir}/remote/bin"
readonly condir="${rootdir}/remote/console"
username="$(whoami)"
readonly username

#### 主体 ####
if [[ ! -d "${repores}" ]]; then
  err "${oneself##*/}: remote-resource not found"
  exit "${E_NOT_FOUND}"
fi

for con_dir in ${CON_DIRS}; do
  con_path="${rootdir}/remote/console/${con_dir}"
  
  if [[ "${con_dir}" == "master-all" ]]; then
    cp "${repores}"/master-all-config.ini "${con_path}"/config.ini
  elif [[ "${con_dir}" == "master-batch" ]]; then
    cp "${repores}"/master-batch-config.ini "${con_path}"/config.ini
  else
    cp "${repores}"/slave-x-y-config.ini "${con_path}"/config.ini
  fi
  
  cp "${resdir}"/remote-config.exe "${con_path}"
done

cp "${resdir}"/remote-upload.exe "${rootdir}"/remote/console/upload

cp "${resdir}/${drive}-远程配置V2.3.2.lnk" /c/Users/"${username}"/Desktop/远程配置V2.3.2.lnk

cat > /c/Users/"${username}"/remote.sh <<-EOF
#!/bin/bash
#
# 远程配置的链接
set -euo pipefail

# 可复制到 C:\Program Files\Git\usr\bin

bash ${bindir}/remote.sh "\$@"
EOF

. "${bindir}"/config_console.sh
