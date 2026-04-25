#!/bin/bash

# Vault Configuration
export VAULT_NAME="writings"
export VAULT_ROOT="$HOME/github/writings"

# Sub-directory for Kanban (Dynamic)
export KANBAN_SUBDIR="40 - Course"

# Derived Paths
export KANBAN_DIR="$VAULT_ROOT/$KANBAN_SUBDIR"
export TEMPLATE_DIR="$VAULT_ROOT/templates"
export INBOX_DIR="$VAULT_ROOT"

# Binary Paths
export OBSIDIAN_BIN="/home/yeasin/.local/bin/obsidian"
