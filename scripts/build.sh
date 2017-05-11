#!/bin/bash

set -ex

civetweb_version=${CIVETWEB_VERSION:-$(get-latest-release-tag.sh civetweb civetweb | tr -d 'v')}
git clone --depth 1 -b v${civetweb_version} ${CIVETWEB_CLONE_URL}
cd civetweb
make
