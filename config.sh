#!/usr/bin/env bash

#
# Package Config


#
# Stores information regarding the execution of a procedure or function.
# Below is a description of the expected keys.
#
# - function  : Name of the last function performed.
#               Default Value : '-'
# - status    : Outbound status value.
#               Default Value : '0'
# - return    : Function return value.
#               Default Value : ""
#               Functions that return multiple values will have only the first
#               one stored in this location, all returns will be stored in the
#               'SHELLNS_RESULT_RETURN' array
#
unset SHELLNS_RESULT_DATA
declare -gA SHELLNS_RESULT_DATA
SHELLNS_RESULT_DATA["function"]="-"
SHELLNS_RESULT_DATA["status"]="0"
SHELLNS_RESULT_DATA["return"]=""

#
# Stores all the values returned by the functions.
# It's really useful when a function returns more than one value.
declare -ga SHELLNS_RESULT_RETURN=()
