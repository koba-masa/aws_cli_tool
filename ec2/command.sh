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
