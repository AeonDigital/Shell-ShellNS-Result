#!/usr/bin/env bash

#
# Saves the result of the execution of a function or procedure.
#
# @param string $1
# ::
#   - default : "-"
# ::
# Name of the function performed.
#
# @param ?int $2
# ::
#   - default : "0"
# ::
# Function output status.  
# If it is not an integer, it will use **1**.
#
# @param ?string $3...
# All parameters from this position onwards refer to values returned by the
# executed function.
#
# @return void
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