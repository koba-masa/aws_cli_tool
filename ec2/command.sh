#!/bin/bash

source $(cd "$( dirname "$0" )" && pwd -P)/ec2/aws_cli.sh
source $(cd "$( dirname "$0" )" && pwd -P)/ec2/utility.sh

function serverlist() {
  local query="Reservations[*].Instances[*].{ServerName:Tags[?Key=='Name']|[0].Value,PrivateIpAddress:PrivateIpAddress}"
  local filter=""
  if [ "$1" == "--vpc" ]; then
    filter="Name=vpc-id,Values=$(get_my_vpc_id)"
  fi
  describe-instances ${EXEC_TYPE_STDOUT} "${OUTPUT_TYPE_TABLE}" "${query}" "${filter}" ""
}

function get_my_instance_name() {
  local instance_id=$(get_my_instance_id)
  local query="Tags[*].Value"
  local filter="Name=key,Values=Name Name=resource-id,Values=${instance_id}"
  echo $(describe-tags ${EXEC_TYPE_RESULT} "${OUTPUT_TYPE_TEXT}" "${query}" "${filter}" "")
}
