
RLX=compiler/build/linux_compiler.elf
RLX_FLAGS?=--linux --debug --dwarf
DBG?=

BUILD=./build

madblocks: $(BUILD)/madblocks
	cp $(BUILD)/madblocks madblocks
	chmod +x madblocks

LIGHT_CLEAN_FILES+= madblocks
CLEAN_FILES+= madblocks

$(BUILD)/madblocks: $(RLX)
$(BUILD)/madblocks: $(BUILD)/Main.d
$(BUILD)/madblocks: $(shell cat $(BUILD)/Main.d 2>/dev/null)
	$(DBG)$(RLX) -i ./Main.rlx -o $@ ${RLX_FLAGS}

secret-internal-deps: $(BUILD)/Main.d

$(BUILD)/Main.d: $(RLX)
	$(DBG)$(RLX) -i ./Main.rlx -o $@ $(RLX_FLAGS) --makedep

LIGHT_CLEAN_FILES+= $(BUILD)/madblocks
CLEAN_FILES+= $(BUILD)/madblocks $(BUILD)/Main.d

clean:
	rm -f $(LIGHT_CLEAN_FILES)

clean-all: clean
	rm -f $(CLEAN_FILES)

depend dep deps:
	rm -f $(BUILD)/*.d
	$(MAKE) secret-internal-deps

build: madblocks

rebuild: clean build
