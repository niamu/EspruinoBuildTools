#!/bin/bash

set -ue

SCRIPT_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

docker run \
	--rm \
	-it \
	-w /espruino \
	-v "$SCRIPT_PATH/../../":/espruino \
	espressif/idf:release-v3.3 \
	bash -c "esp32/build/build-idf.sh && esp32/build/build-tgz.sh"
