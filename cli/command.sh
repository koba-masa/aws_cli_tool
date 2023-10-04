#!/bin/bash

function command_list() {
  source $(cd "$( dirname "$0" )" && pwd -P)/cli/aws_cli_help.sh
  local reload=0
  local options=""
  for option in "$@"
  do
    case ${option} in
      "--reload")
        shift
        reload=1
        ;;
      *)
        options="${options} ${option}"
        ;;
    esac
  done
  aws_help "${reload}" ${options}
}
