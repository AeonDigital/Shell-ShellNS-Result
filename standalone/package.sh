#!/usr/bin/env bash

if [[ "$(declare -p "SHELLNS_STANDALONE_LOAD_STATUS" 2> /dev/null)" != "declare -A"* ]]; then
  declare -gA SHELLNS_STANDALONE_LOAD_STATUS
fi
SHELLNS_STANDALONE_LOAD_STATUS["shellns_result_standalone.sh"]="ready"
unset SHELLNS_STANDALONE_DEPENDENCIES
declare -gA SHELLNS_STANDALONE_DEPENDENCIES
shellNS_standalone_install_set_dependency() {
  local strDownloadFileName="shellns_${2,,}_standalone.sh"
  local strPkgStandaloneURL="https://raw.githubusercontent.com/AeonDigital/${1}/refs/heads/main/standalone/package.sh"
  SHELLNS_STANDALONE_DEPENDENCIES["${strDownloadFileName}"]="${strPkgStandaloneURL}"
}
declare -gA SHELLNS_DIALOG_TYPE_COLOR=(
  ["raw"]=""
  ["info"]="\e[1;34m"
  ["warning"]="\e[0;93m"
  ["error"]="\e[1;31m"
  ["question"]="\e[1;35m"
  ["input"]="\e[1;36m"
  ["ok"]="\e[20;49;32m"
  ["fail"]="\e[20;49;31m"
)
declare -gA SHELLNS_DIALOG_TYPE_PREFIX=(
  ["raw"]=" - "
  ["info"]="inf"
  ["warning"]="war"
  ["error"]="err"
  ["question"]=" ? "
  ["input"]=" < "
  ["ok"]=" v "
  ["fail"]=" x "
)
declare -g SHELLNS_DIALOG_PROMPT_INPUT=""
shellNS_standalone_install_dialog() {
  local strDialogType="${1}"
  local strDialogMessage="${2}"
  local boolDialogWithPrompt="${3}"
  local codeColorPrefix="${SHELLNS_DIALOG_TYPE_COLOR["${strDialogType}"]}"
  local strMessagePrefix="${SHELLNS_DIALOG_TYPE_PREFIX[${strDialogType}]}"
  if [ "${strDialogMessage}" != "" ] && [ "${codeColorPrefix}" != "" ] && [ "${strMessagePrefix}" != "" ]; then
    local strIndent="        "
    local strPromptPrefix="      > "
    local codeColorNone="\e[0m"
    local codeColorText="\e[0;49m"
    local codeColorHighlight="\e[1;49m"
    local tmpCount="0"
    while [[ "${strDialogMessage}" =~ "**" ]]; do
      ((tmpCount++))
      if (( tmpCount % 2 != 0 )); then
        strDialogMessage="${strDialogMessage/\*\*/${codeColorHighlight}}"
      else
        strDialogMessage="${strDialogMessage/\*\*/${codeColorNone}}"
      fi
    done
    local codeNL=$'\n'
    strDialogMessage=$(echo -ne "${strDialogMessage}")
    strDialogMessage="${strDialogMessage//${codeNL}/${codeNL}${strIndent}}"
    local strShowMessage=""
    strShowMessage+="[ ${codeColorPrefix}${strMessagePrefix}${codeColorNone} ] "
    strShowMessage+="${codeColorText}${strDialogMessage}${codeColorNone}\n"
    echo -ne "${strShowMessage}"
    if [ "${boolDialogWithPrompt}" == "1" ]; then
      SHELLNS_DIALOG_PROMPT_INPUT=""
      read -r -p "${strPromptPrefix}" SHELLNS_DIALOG_PROMPT_INPUT
    fi
  fi
  return 0
}
shellNS_standalone_install_dependencies() {
  if [[ "$(declare -p "SHELLNS_STANDALONE_DEPENDENCIES" 2> /dev/null)" != "declare -A"* ]]; then
    return 0
  fi
  if [ "${#SHELLNS_STANDALONE_DEPENDENCIES[@]}" == "0" ]; then
    return 0
  fi
  local pkgFileName=""
  local pkgSourceURL=""
  local pgkLoadStatus=""
  for pkgFileName in "${!SHELLNS_STANDALONE_DEPENDENCIES[@]}"; do
    pgkLoadStatus="${SHELLNS_STANDALONE_LOAD_STATUS[${pkgFileName}]}"
    if [ "${pgkLoadStatus}" == "" ]; then pgkLoadStatus="0"; fi
    if [ "${pgkLoadStatus}" == "ready" ] || [ "${pgkLoadStatus}" -ge "1" ]; then
      continue
    fi
    if [ ! -f "${pkgFileName}" ]; then
      pkgSourceURL="${SHELLNS_STANDALONE_DEPENDENCIES[${pkgFileName}]}"
      curl -o "${pkgFileName}" "${pkgSourceURL}"
      if [ ! -f "${pkgFileName}" ]; then
        local strMsg=""
        strMsg+="An error occurred while downloading a dependency.\n"
        strMsg+="URL: **${pkgSourceURL}**\n\n"
        strMsg+="This execution was aborted."
        shellNS_standalone_install_dialog "error" "${strMsg}"
        return 1
      fi
    fi
    chmod +x "${pkgFileName}"
    if [ "$?" != "0" ]; then
      local strMsg=""
      strMsg+="Could not give execute permission to script:\n"
      strMsg+="FILE: **${pkgFileName}**\n\n"
      strMsg+="This execution was aborted."
      shellNS_standalone_install_dialog "error" "${strMsg}"
      return 1
    fi
    SHELLNS_STANDALONE_LOAD_STATUS["${pkgFileName}"]="1"
  done
  if [ "${1}" == "1" ]; then
    for pkgFileName in "${!SHELLNS_STANDALONE_DEPENDENCIES[@]}"; do
      pgkLoadStatus="${SHELLNS_STANDALONE_LOAD_STATUS[${pkgFileName}]}"
      if [ "${pgkLoadStatus}" == "ready" ]; then
        continue
      fi
      . "${pkgFileName}"
      if [ "$?" != "0" ]; then
        local strMsg=""
        strMsg+="An unexpected error occurred while load script:\n"
        strMsg+="FILE: **${pkgFileName}**\n\n"
        strMsg+="This execution was aborted."
        shellNS_standalone_install_dialog "error" "${strMsg}"
        return 1
      fi
      SHELLNS_STANDALONE_LOAD_STATUS["${pkgFileName}"]="ready"
    done
  fi
}
shellNS_standalone_install_dependencies "1"
unset shellNS_standalone_install_set_dependency
unset shellNS_standalone_install_dependencies
unset shellNS_standalone_install_dialog
unset SHELLNS_STANDALONE_DEPENDENCIES
unset SHELLNS_RESULT_DATA
declare -gA SHELLNS_RESULT_DATA
SHELLNS_RESULT_DATA["function"]="-"
SHELLNS_RESULT_DATA["status"]="0"
SHELLNS_RESULT_DATA["return"]=""
declare -ga SHELLNS_RESULT_RETURN=()
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
shellNS_result_reset() {
  unset SHELLNS_RESULT_DATA
  declare -gA SHELLNS_RESULT_DATA
  SHELLNS_RESULT_DATA["function"]="-"
  SHELLNS_RESULT_DATA["status"]="0"
  SHELLNS_RESULT_DATA["return"]=""
  unset SHELLNS_RESULT_RETURN
  declare -ga SHELLNS_RESULT_RETURN=()
}
shellNS_result_count() {
  echo "${#SHELLNS_RESULT_RETURN[@]}"
}
SHELLNS_TMP_PATH_TO_DIR_MANUALS="$(tmpPath=$(dirname "${BASH_SOURCE[0]}"); realpath "${tmpPath}/src-manuals/${SHELLNS_CONFIG_INTERFACE_LOCALE}")"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_result_count"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/result/count.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_result_reset"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/result/reset.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_result_set"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/result/set.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_result_show"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/result/show.man"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["result.count"]="shellNS_result_count"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["result.reset"]="shellNS_result_reset"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["result.set"]="shellNS_result_set"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["result.show"]="shellNS_result_show"
unset SHELLNS_TMP_PATH_TO_DIR_MANUALS
