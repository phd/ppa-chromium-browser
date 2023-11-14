#!/bin/bash -e

cd $(dirname "$0")

. config

V1="${1}"
V2="${2}"

output="$(./copy-packages.sh || true)"

echo "$output" > ./copy-packages.sh.log

./mail.sh "${EMAIL}" "chromium-browser updated in ${USER}" <<< "${V1}\n->\n${V2}\n\n[BEGIN]\n${output}\n[END]\n"

exit 0
