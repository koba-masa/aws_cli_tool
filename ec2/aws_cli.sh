#!/bin/sh
EXEC_TYPE_STDOUT=0
EXEC_TYPE_RESULT=1

OUTPUT_TYPE_TABLE="table"
OUTPUT_TYPE_TEXT="text"
OUTPUT_TYPE_JSON="json"

PROFILE_DEFAULT="default"

function describe-instances() {
    local exec_type=$1
    local output_type=""
    test "$2" != "" && output_type=$2 || output_type="table"
    local query=""
    test "$3" != "" && query="--query $3" || query=""
    local filter=""
    test "$4" != "" && filter="--filters $4" || filter=""
    local profile=""
    test "$5" != "" && profile=$5 || profile="${PROFILE_DEFAULT}"

    if [ ${exec_type} -eq ${EXEC_TYPE_STDOUT} ]; then
      aws ec2 describe-instances ${query} --output ${output_type} ${query} ${filter} --profile ${profile}
    else
      echo $(aws ec2 describe-instances ${query} --output ${output_type} ${query} ${filter} --profile ${profile})
    fi
}
