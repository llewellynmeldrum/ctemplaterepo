# Config: Change to desired project name. Project name has strings appended unless release.
PROJECT := main
CC := gcc



SRC_DIR := src
OBJ_DIR := build
INC_DIR := include

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

CFLAGS_DEFAULT := -I$(INC_DIR)
CFLAGS_DEBUG := -I$(INC_DIR) -O0 -g
CFLAGS_RELEASE := -I$(INC_DIR) -Wall -Wextra -g3

BIN_DEFAULT := $(PROJECT)-dev
BIN_DEBUG := $(PROJECT)-debug
BIN_RELEASE := $(PROJECT)

# Default target 
$(BIN_DEFAULT): CFLAGS := $(CFLAGS_DEFAULT)
$(BIN_DEFAULT): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

# Debug target
$(BIN_DEBUG): CFLAGS := $(CFLAGS_DEBUG)
$(BIN_DEBUG): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

# Release target
$(BIN_RELEASE): CFLAGS := $(CFLAGS_RELEASE)
$(BIN_RELEASE): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

# compile (shared between all targets) 
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Ensure build dir exists
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# entrypoints
default: $(BIN_DEFAULT)
debug: $(BIN_DEBUG)
release: $(BIN_RELEASE)

clean:
	rm -rf $(OBJ_DIR) $(BIN_DEFAULT) $(BIN_DEBUG) $(BIN_RELEASE)

.PHONY: default debug release clean

