#!/bin/bash

CACHE_DIR="`dirname $0`/tmp/cache"

RELOAD_CACHE=1

function aws_help() {
  local reload=$1
  local command=$2

  local cache_file=`_cache_file ${command}`
  if [[ ${reload} -eq ${RELOAD_CACHE} && -e "${cache_file}" ]]; then
    rm ${cache_file}
  fi
  local help=""
  local title="aws <command>"
  if [ ! -e "${cache_file}" ]; then
    help=`aws ${command} help | col -b`
    if [ "${command}" != "" ]; then
      help=`_aws_command_help "${help}" "${command}"`
      title="aws ${command} <subcommand>"
    else
      help=`_aws_help "${help}"`
    fi
    help=`echo "${help}" | grep -v '^[[:space:]]*$'`
    help=`echo "${help}" | sed 's/^       o/ /g'`
    echo "${title}" > ${cache_file}
    echo "${help}" >> ${cache_file}
  fi
  cat ${cache_file}
}

function _cache_file() {
  local command=$1
  local cache_file="${CACHE_DIR}/aws.txt"
  if [ "${command}" != "" ]; then
    cache_file="${CACHE_DIR}/${command}.txt"
  fi
  echo ${cache_file}
}

function _aws_help() {
  local help=$1
  echo "${help}" | awk '/AVAILABLE SERVICES/,/SEE ALSO/' | sed '1d;$d'
}

function _aws_command_help() {
  local help=$1
  local end_word=`echo $2 | sed 's/[a-z]/\U&/g'`
  echo "${help}" | awk "/AVAILABLE COMMANDS/,/${end_word}()/" | sed '1d;$d'
}