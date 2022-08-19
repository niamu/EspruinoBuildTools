#!/bin/bash

set -ue

BASE_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ESPRUINO_BRANCH=${1:-RELEASE_2V08-picod4}

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
echo "Using Espruino: $ESPRUINO_BRANCH"
echo "--------------------------------------"
echo ""

# checkout esp-idf branch and update submodule
cd "$BASE_PATH/Espruino"
git fetch origin
git checkout $ESPRUINO_BRANCH
git submodule update --init --recursive

# expand app.tgz and esp-idf.tgz into Espruino directory
rm -rf "$IDF_PATH/../Espruino/app" "$IDF_PATH/../Espruino/esp-idf"
tar xfz "$IDF_PATH/../../deploy/esp-idf.tgz" -C "$IDF_PATH/../Espruino/"
tar xfz "$IDF_PATH/../../deploy/app.tgz" -C "$IDF_PATH/../Espruino/"

make clean
BOARD="ESP32" make

cat "$BASE_PATH/Espruino/targets/esp32/README_flash.txt"
