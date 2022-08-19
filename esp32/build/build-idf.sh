#!/bin/bash

set -ue

BASE_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ESP_IDF_BRANCH=${1:-v3.1.3-picod4}

if ! type xtensa-esp32-elf-gcc &> /dev/null; then
    echo "xtensa-esp32-elf-gcc not found on PATH. Exiting."
    exit 1
fi

# adjust paths to this folder versions
export ESP_IDF_PATH="$BASE_PATH/esp-idf"
export ESP_APP_TEMPLATE_PATH="$BASE_PATH/app"
export IDF_PATH="$ESP_IDF_PATH"

echo ""
echo "--------------------------------------"
echo "Using esp-idf: $ESP_IDF_BRANCH"
echo "--------------------------------------"
echo ""

# checkout esp-idf branch and update submodule
cd "$BASE_PATH/esp-idf"
git fetch origin
git checkout $ESP_IDF_BRANCH
git submodule update --init --recursive

cd "$BASE_PATH/app"
make clean
make
rm "$BASE_PATH/app/build/espruino-esp32.elf"
make app.tgz
