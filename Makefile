BUILD_DIR = build


$(BUILD_DIR): 
	-mkdir $(BUILD_DIR) 2>/dev/null
	cd $(BUILD_DIR); \
	rm -rf *

release: extras
	cd $(BUILD_DIR); \
	cmake -DCMAKE_BUILD_TYPE=Release ..

debug: extras
	cd $(BUILD_DIR); \
	cmake ..

xcode: extras
	cd $(BUILD_DIR); \
	cmake -G Xcode  ..

# This is for cross-compiling for Windows via MinGW32
windows: extras
	cd $(BUILD_DIR); \
	cmake -DCMAKE_TOOLCHAIN_FILE=../Toolchain-mingw32.cmake -DCMAKE_BUILD_TYPE=Release ..

clean: $(BUILD_DIR)
	cd $(BUILD_DIR); \
	rm -rf *

extras: $(BUILD_DIR) $(BUILD_DIR)/README.html $(BUILD_DIR)/LICENSE.html $(BUILD_DIR)/enumMap.txt

$(BUILD_DIR)/README.html: README.md
	multimarkdown -o $(BUILD_DIR)/README.html README.md

$(BUILD_DIR)/LICENSE.html: LICENSE.txt
	multimarkdown -o $(BUILD_DIR)/LICENSE.html LICENSE.txt

map: $(BUILD_DIR)/enumMap.txt

$(BUILD_DIR)/enumMap.txt: src/libMultiMarkdown.h
	./enumsToPerl.pl src/libMultiMarkdown.h $(BUILD_DIR)/enumMap.txt
