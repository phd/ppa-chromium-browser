#!/bin/bash -e

F_VERSION='check.sh.version'
F_VERSION_OLD='check.sh.version.old'
F_CHECKED='check.sh.checked'

cd $(dirname "$0")

. config

V1=$(cat "${F_VERSION}" 2>/dev/null || true)

for delay in 0 1 5 10 30 60 120 300 600; do
    sleep "${delay}"
    V2=$(
        curl -s https://launchpad.net/ubuntu/bionic/+source/chromium-browser                   \
        | tr '\n' ' ' | sed -E 's, +, ,g' | sed -E 's,> <,><,g'                                \
        | sed -E 's,.*<dl[^>]*><dt[^>]*>Current version:</dt><dd[^>]*>([^<]+)</dd></dl>.*,\1,' \
        | sed -E 's,.*<html.*,,'
    )
    [ -n "${V2}" ] && break
done

regexp='^[0-9][0-9.:]+[^ ]*$'

if [[ ! "${V2}" =~ $regexp ]]; then

    echo 'error'

    ./mail.sh "${EMAIL}" 'chromium-browser version check error' "${V1}\n->\nhttps://launchpad.net/ubuntu/bionic/+source/chromium-browser\n\n${V2}\n"

elif [ "${V1}" != "${V2}" ]; then

    echo "${V2}"

    mv "${F_VERSION}" "${F_VERSION_OLD}" || true
    echo "${V2}" > "${F_VERSION}"
    touch "${F_VERSION}"
    ./mail.sh "${EMAIL}" 'chromium-browser updated in Ubuntu' "${V1}\n->\n${V2}\n"

    echo "${PWD}/copy-packages-run.sh ${V1} ${V2}" | at now

fi

touch "${F_CHECKED}"

exit 0
