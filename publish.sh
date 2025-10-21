#!/bin/bash

set -euo pipefail

DEBUG=${DEBUG:-false}
if ${DEBUG} ; then
    set -x
fi

SCRIPT_DIR="$(cd $(dirname "$0") && pwd)"

ALT_FORGEJO_TOKEN=${ALT_FORGEJO_TOKEN:-""}
CODEBERG_FORGEJO_TOKEN=${CODEBERG_FORGEJO_TOKEN:-""}

if [ -z "${ALT_FORGEJO_TOKEN}" ]; then
    echo "ALT_FORGEJO_TOKEN is not set"
    exit 1
fi
if [ -z "${CODEBERG_FORGEJO_TOKEN}" ]; then
    echo "CODEBERG_FORGEJO_TOKEN is not set"
    exit 1
fi

FORGEJO_USER=${USER:-''}

for i in alt codeberg; do
    if [[ ${i} == "alt" ]] ; then
        BASE_URL="https://altlinux.space"
        FORGEJO_TOKEN=${ALT_FORGEJO_TOKEN}
    else
        BASE_URL="https://codeberg.org"
        FORGEJO_TOKEN=${CODEBERG_FORGEJO_TOKEN}
    fi

    DEB_PKG=$(ls dist/*.deb)
    echo "Uploading ${DEB_PKG} to ${BASE_URL} for Debian ..."
    curl -sSL --user ${FORGEJO_USER}:${FORGEJO_TOKEN} \
        --upload-file ${DEB_PKG} \
        ${BASE_URL}/api/packages/${FORGEJO_USER}/debian/pool/stable/main/upload

    RPM_PKG=$(ls dist/*.rpm)
    echo "Uploading ${RPM_PKG} to ${BASE_URL} for RHEL/SUSE ..."
    curl -sSL --user ${FORGEJO_USER}:${FORGEJO_TOKEN} \
        --upload-file ${RPM_PKG} \
        ${BASE_URL}/api/packages/${FORGEJO_USER}/rpm/upload

    echo "Uploading ${RPM_PKG} to ${BASE_URL} for ALT Linux ..."
    curl -sSL --user ${FORGEJO_USER}:${FORGEJO_TOKEN} \
        --upload-file ${DEB_PKG} \
        ${BASE_URL}/api/packages/${FORGEJO_USER}/alt/upload

    ARCH_PKG=$(ls dist/*.pkg.tar.zst)
    echo "Uploading ${ARCH_PKG} to ${BASE_URL} for Arch Linux ..."
    curl -sSL -XPUT --user ${FORGEJO_USER}:${FORGEJO_TOKEN} \
        --header "Content-Type: application/octet-stream" \
        --data-binary "@${ARCH_PKG}" \
        ${BASE_URL}/api/packages/${FORGEJO_USER}/arch/extras
done
echo "All packages uploaded successfully."
