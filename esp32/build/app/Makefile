#
# This is a project Makefile. It is assumed the directory this Makefile resides in is a
# project subdirectory.
#

PROJECT_NAME := espruino-esp32
IDF_PATH=$(ESP_IDF_PATH)

include $(ESP_IDF_PATH)/make/project.mk

app.tgz:
	echo "Building esp-idf.tgz and app.tgz..."
	mkdir -p "$(ESP_IDF_PATH)/../../deploy"
	tar cfz "$(ESP_IDF_PATH)/../../deploy/esp-idf.tgz" \
		`find "$(ESP_IDF_PATH)/../esp-idf/components/" -name *.h` \
		`find "$(ESP_IDF_PATH)/../esp-idf/components/" -name *.a` \
		`find "$(ESP_IDF_PATH)/../esp-idf/components/" -name *.ld` \
		`find "$(ESP_IDF_PATH)/../esp-idf/components/esptool_py/esptool/esptool.py"`
	tar cfz "$(ESP_IDF_PATH)/../../deploy/app.tgz" \
		`find "$(ESP_IDF_PATH)/../app" -name *.a` \
		`find "$(ESP_IDF_PATH)/../app/build/" -name sdkconfig.h` \
		`find "$(ESP_IDF_PATH)/../app/build/" -name *.ld` \
		`find "$(ESP_IDF_PATH)/../app/build/" -name partitions*.bin` \
		`find "$(ESP_IDF_PATH)/../app/build/" -name bootloader.bin`
