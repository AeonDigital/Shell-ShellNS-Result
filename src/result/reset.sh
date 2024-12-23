#!/usr/bin/env bash

#
# Restarts the run information array.
#
# @return void
shellNS_result_reset() {
  unset SHELLNS_RESULT_DATA
  declare -gA SHELLNS_RESULT_DATA
  SHELLNS_RESULT_DATA["function"]="-"
  SHELLNS_RESULT_DATA["status"]="0"
  SHELLNS_RESULT_DATA["return"]=""

  unset SHELLNS_RESULT_RETURN
  declare -ga SHELLNS_RESULT_RETURN=()
}