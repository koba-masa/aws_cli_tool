#!/bin/bash

function get_my_vpc_id() {
  local query="Reservations[*].Instances[*].NetworkInterfaces[*].VpcId"
  local filter="Name=instance-id,Values=$(get_my_instance_id)"
  echo `describe-instances "${EXEC_TYPE_RESULT}" "${OUTPUT_TYPE_TEXT}" "${query}" "${filter}" "${PROFILE_DEFAULT}"`
}

function get_my_instance_id() {
  local instance_id=$(ec2-metadata -i | awk '{print $2}')
  echo ${instance_id}
}
