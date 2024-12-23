#!/usr/bin/env bash

#
# Prints the result of the last recorded execution on the screen.
#
# @param ?int $1
# Number of the stored result that should be returned.  
# If it is not informed, it will take the first amount recorded.
#
# If the value entered is invalid, it will not print anything and return the
# value status of 255.
#
# @return status+?string
# Returns the last registered status code and prints the return value, if it
# exists and if it is different from "".
shellNS_result_show() {
  local intTargetReturn="0"
  if [[ "${1}" =~ ^-?[0-9]+$ ]]; then
    intTargetReturn="${1}"
  fi

  if [ "${intTargetReturn}" -ge "${#SHELLNS_RESULT_RETURN[@]}" ]; then
    return 255
  fi


  local intResultStatus="${SHELLNS_RESULT_DATA["status"]}"
  local strResultReturn="${SHELLNS_RESULT_RETURN["${intTargetReturn}"]}"

  if [ "${strResultReturn}" != "" ]; then
    echo -n "${strResultReturn}"
  fi
  return "${intResultStatus}"
}