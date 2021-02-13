#!bin/bash -x
function_type=""
function_name=""
function_args=""
if [ $# -lt 2 ]; then
  echo "[ERROR] A mount of parameter was worng."
  exit 99
fi
function_type=$1
function_name=$2
if [ $# -ge 3 ]; then
  function_args=(${@:3:$#})
fi

base_dir=$(cd "$( dirname "$0" )" && pwd -P)
case "${function_type}" in
  "ec2")
    source ${base_dir}/ec2/command.sh
    ;;
  *)
    echo "[ERROR] This function type('${function_type}') is not defined."
    exit 99
    ;;
esac

command_type=$(type -t ${function_name})
if [ "${command_type}" != "function" ]; then
  echo "[ERROR] This function name('${function_name}') is not defined."
  exit 99
fi

${function_name} ${function_args}

exit 0
