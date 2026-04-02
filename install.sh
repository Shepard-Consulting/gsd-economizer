#!/bin/bash
# GSD Economical Installer
# Adds the /gsd:economical command to your GSD installation

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  GSD Economical — Smart Model Routing Plugin${NC}"
echo -e "${BLUE}  Save 50-70% on your GSD builds${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Determine install location
GLOBAL_DIR="$HOME/.claude"
LOCAL_DIR="./.claude"

if [ "$1" = "--global" ] || [ "$1" = "-g" ]; then
    TARGET_DIR="$GLOBAL_DIR"
    INSTALL_TYPE="global"
elif [ "$1" = "--local" ] || [ "$1" = "-l" ]; then
    TARGET_DIR="$LOCAL_DIR"
    INSTALL_TYPE="local"
else
    echo "Where do you want to install?"
    echo "  1) Global (all projects) — $GLOBAL_DIR"
    echo "  2) Local (current project only) — $LOCAL_DIR"
    echo ""
    read -p "Choice [1/2]: " choice
    case $choice in
        1) TARGET_DIR="$GLOBAL_DIR"; INSTALL_TYPE="global" ;;
        2) TARGET_DIR="$LOCAL_DIR"; INSTALL_TYPE="local" ;;
        *) echo -e "${RED}Invalid choice. Exiting.${NC}"; exit 1 ;;
    esac
fi

# Verify GSD is installed
if [ ! -d "$TARGET_DIR/commands/gsd" ]; then
    echo -e "${RED}Error: GSD not found at $TARGET_DIR${NC}"
    echo "Install GSD first: npx get-shit-done-cc@latest"
    exit 1
fi

echo -e "${YELLOW}Installing to $TARGET_DIR ($INSTALL_TYPE)...${NC}"
echo ""

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy command
cp "$SCRIPT_DIR/commands/gsd/economical.md" "$TARGET_DIR/commands/gsd/economical.md"
echo -e "  ${GREEN}✓${NC} Command:    /gsd:economical"

# Copy workflow and references
mkdir -p "$TARGET_DIR/gsd-economical/workflows"
mkdir -p "$TARGET_DIR/gsd-economical/references"
cp "$SCRIPT_DIR/workflows/economical.md" "$TARGET_DIR/gsd-economical/workflows/economical.md"
cp "$SCRIPT_DIR/references/classification-rules.md" "$TARGET_DIR/gsd-economical/references/classification-rules.md"
echo -e "  ${GREEN}✓${NC} Workflow:   economical.md"
echo -e "  ${GREEN}✓${NC} Reference:  classification-rules.md"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Installed! Run /gsd:economical after /gsd:new-project${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
