TOOL_NAME = danger-kotlin

PREFIX = /usr/local
INSTALL_PATH = $(PREFIX)/bin/$(TOOL_NAME)
BUILD_PATH = danger-kotlin/build/bin/runner/releaseExecutable/$(TOOL_NAME).kexe
LIB_INSTALL_PATH = $(PREFIX)/lib/danger
LIB_FLAT_DIR = $(LIB_INSTALL_PATH)/libs

install: build
	mkdir -p $(PREFIX)/bin
	mkdir -p $(LIB_INSTALL_PATH)
	mkdir -p $(LIB_FLAT_DIR)
	ls -l $(BUILD_PATH)
	cp -fv $(BUILD_PATH) $(INSTALL_PATH)
	ls -l danger-kotlin-library/build/libs/danger-kotlin.jar
	ls -l $(LIB_INSTALL_PATH)
	cp -fv danger-kotlin-library/build/libs/danger-kotlin.jar $(LIB_INSTALL_PATH)/danger-kotlin.jar
	./gradlew --status
	./gradlew --stop
	echo "finished installing danger-kotlin"

build:
	./gradlew build -p danger-plugin-installer
	./gradlew install -p danger-plugin-installer
	./gradlew shadowJar -p danger-kotlin-library
	./gradlew build -p danger-kotlin-kts
	./gradlew build -p danger-kotlin

uninstall:
	rm -rf $(INSTALL_PATH)
	rm -f $(LIB_INSTALL_PATH)/danger-kotlin.jar
	rm -f $(LIB_FLAT_DIR)
