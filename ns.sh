#!/usr/bin/env bash

#
# Get path to the manuals directory.
SHELLNS_TMP_PATH_TO_DIR_MANUALS="$(tmpPath=$(dirname "${BASH_SOURCE[0]}"); realpath "${tmpPath}/src-manuals/${SHELLNS_CONFIG_INTERFACE_LOCALE}")"


#
# Mapp function to manual.
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_result_count"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/result/count.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_result_reset"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/result/reset.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_result_set"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/result/set.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_result_show"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/result/show.man"


#
# Mapp namespace to function.
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["result.count"]="shellNS_result_count"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["result.reset"]="shellNS_result_reset"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["result.set"]="shellNS_result_set"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["result.show"]="shellNS_result_show"





unset SHELLNS_TMP_PATH_TO_DIR_MANUALS