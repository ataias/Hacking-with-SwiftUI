SOURCES = $(wildcard GuessTheFlag/**/*.swift)
SCHEME=GuessTheFlag
DEVICE=$(shell xcrun simctl list 'devices' 'booted' -j | jq .devices | sed 's|com.apple.CoreSimulator.SimRuntime.||' | jq .\"iOS-13-4\" | jq first.udid)

build: $(SOURCES)
	xcodebuild -configuration Debug -scheme $(SCHEME) -sdk iphonesimulator
	xcodebuild -configuration Debug -scheme $(SCHEME) -sdk iphonesimulator -showBuildSettings | grep "CODESIGNING_FOLDER_PATH" | awk '{print $$3}' > build

app_bundle: build
	xcodebuild -configuration Debug -scheme $(SCHEME) -sdk iphonesimulator -showBuildSettings | grep "PRODUCT_BUNDLE_IDENTIFIER" | awk '{print $$3}' > app_bundle

.PHONY: install
install: build
	xcrun simctl install $(DEVICE) $(shell cat build)

.PHONY: run
run: build app_bundle
	xcrun simctl launch $(DEVICE) $(shell cat app_bundle)
	open -a Simulator
