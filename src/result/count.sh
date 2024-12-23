#!/usr/bin/env bash

#
# Prints on the screen the number of values currently recorded in
# **SHELLNS_RESULT_RETURN**.
#
# @return int
shellNS_result_count() {
  echo "${#SHELLNS_RESULT_RETURN[@]}"
}