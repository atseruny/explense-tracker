# GNU Make convenience wrapper. CMake is the source of build configuration.
CMAKE ?= cmake
PRESET ?= debug
QT_PREFIX ?=

ifneq ($(strip $(QT_PREFIX)),)
QT_CMAKE_ARG := -DCMAKE_PREFIX_PATH="$(QT_PREFIX)"
endif

.DEFAULT_GOAL := help
.PHONY: help configure build clean

help:
	@echo make configure     - Configure the debug scaffold
	@echo make build         - Configure and build
	@echo make clean         - Clean an existing build
	@echo Use PRESET=release for a release build
	@echo Use QT_PREFIX=path to select a Qt desktop kit
	@echo On Windows, mingw32-make can be used instead of make

configure:
	"$(CMAKE)" --preset "$(PRESET)" $(QT_CMAKE_ARG)

build: configure
	"$(CMAKE)" --build --preset "$(PRESET)"

clean:
	"$(CMAKE)" --build "build/$(PRESET)" --target clean
