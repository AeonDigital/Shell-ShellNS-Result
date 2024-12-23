#!/usr/bin/env bash

unset SHELLNS_RESULT_DATA
declare -gA SHELLNS_RESULT_DATA
SHELLNS_RESULT_DATA["function"]="-"
SHELLNS_RESULT_DATA["status"]="0"
SHELLNS_RESULT_DATA["return"]=""
declare -ga SHELLNS_RESULT_RETURN=()
shellNS_result_reset() {
  unset SHELLNS_RESULT_DATA
  declare -gA SHELLNS_RESULT_DATA
  SHELLNS_RESULT_DATA["function"]="-"
  SHELLNS_RESULT_DATA["status"]="0"
  SHELLNS_RESULT_DATA["return"]=""
  unset SHELLNS_RESULT_RETURN
  declare -ga SHELLNS_RESULT_RETURN=()
}
shellNS_result_set() {
  local strResultFunction="${1:-'-'}"
  local intResultStatus="${2:-'0'}"
  local strResultReturn="${3}"
  if ! [[ "${intResultStatus}" =~ ^[0-9]+$ ]]; then
    intResultStatus="1"
  fi
  SHELLNS_RESULT_DATA["function"]="${strResultFunction}"
  SHELLNS_RESULT_DATA["status"]="${intResultStatus}"
  SHELLNS_RESULT_DATA["return"]="${strResultReturn}"
  unset SHELLNS_RESULT_RETURN
  declare -ga SHELLNS_RESULT_RETURN=("${@:3}")
}
shellNS_result_count() {
  echo "${#SHELLNS_RESULT_RETURN[@]}"
}
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
    echo -ne "${strResultReturn}"
  fi
  return "${intResultStatus}"
}

