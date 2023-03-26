#!/bin/bash -e
#export PATH="${HOME}/chromium-browser-ppa/:$PATH"
export BROWSER=echo
export LP_CREDENTIALS_FILE="${HOME}/launchpad.auth"

cd $(dirname "$0")

. config

echo '[focal 20.04]'
./ubuntu-archive-tools/copy-package -y -b --from=ubuntu --from-suite=bionic-security --to=~${USER}/ubuntu/chromium-browser --to-suite=focal   chromium-browser 2>&1 || true

echo '[jammy 22.04]'
./ubuntu-archive-tools/copy-package -y -b --from=ubuntu --from-suite=bionic-security --to=~${USER}/ubuntu/chromium-browser --to-suite=jammy   chromium-browser 2>&1 || true

echo '[kinetic 22.10]'
./ubuntu-archive-tools/copy-package -y -b --from=ubuntu --from-suite=bionic-security --to=~${USER}/ubuntu/chromium-browser --to-suite=kinetic chromium-browser 2>&1 || true

echo '[lunar 23.04]'
./ubuntu-archive-tools/copy-package -y -b --from=ubuntu --from-suite=bionic-security --to=~${USER}/ubuntu/chromium-browser --to-suite=lunar   chromium-browser 2>&1 || true
