#!/usr/bin/env bash

find . -type f -name "${1}" | xargs grep "${2}"
