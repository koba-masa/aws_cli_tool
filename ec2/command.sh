#!/bin/bash

source $(cd "$( dirname "$0" )" && pwd -P)/ec2/aws_cli.sh
source $(cd "$( dirname "$0" )" && pwd -P)/ec2/utility.sh

SORT_OFF=0
SORT_ON=1

function serverlist() {
  local query="sort_by(Reservations[*].Instances[*].{ServerName:Tags[?Key=='Name']|[0].Value,PrivateIpAddress:PrivateIpAddress}[],&ServerName)"
  local filter=""
  local output_type="${OUTPUT_TYPE_TABLE}"
  local sorted=${SORT_OFF}
  local sorted_item=".ServerName, .PrivateIpAddress"
  for option in "$@"
  do
    case ${option} in
      "--vpc")
        filter="Name=vpc-id,Values=$(get_my_vpc_id)"
        ;;
      "--with-status")
        query="sort_by(Reservations[*].Instances[*].{ServerName:Tags[?Key=='Name']|[0].Value,PrivateIpAddress:PrivateIpAddress,Status:State.Name,LaunchTime:LaunchTime}[],&ServerName)"
        sorted_item=".ServerName, .PrivateIpAddress, .Status, .LaunchTime"
        ;;
      "--sort")
        output_type="${OUTPUT_TYPE_JSON}"
        sorted=${SORT_ON}
        ;;
    esac
  done
  if [ ${sorted} -eq ${SORT_ON} ]; then
    # TODO: 標準出力モードではないので、いつか修正する
    local result_json=`describe-instances ${EXEC_TYPE_STDOUT} "${output_type}" "${query}" "${filter}" ""`
    local processed_result=`echo ${result_json} | jq '.[]|[.ServerName, .PrivateIpAddress, .Status, .LaunchTime] | @tsv' | sed -e 's/\"//g'`
    echo -e "ServerName\tPrivateIpAddress\tStatus\tLaunchTime\n${processed_result}" | column -t
  else
    describe-instances ${EXEC_TYPE_STDOUT} "${output_type}" "${query}" "${filter}" ""
  fi
}

function get_my_instance_name() {
  local instance_id=$(get_my_instance_id)
  local query="Tags[*].Value"
  local filter="Name=key,Values=Name Name=resource-id,Values=${instance_id}"
  echo $(describe-tags ${EXEC_TYPE_RESULT} "${OUTPUT_TYPE_TEXT}" "${query}" "${filter}" "")
}
