#!/bin/bash

# =============================================================================
# Git Command Templates - Uninstaller
# =============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_info() { echo -e "${CYAN}→ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }

INSTALL_DIR="$HOME/.git-commands"

echo ""
echo -e "${YELLOW}Git Command Templates - Uninstaller${NC}"
echo ""

# Check if installed
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Git Command Templates is not installed."
    exit 0
fi

# Confirm
read -p "Are you sure you want to uninstall Git Command Templates? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled."
    exit 0
fi

# Remove installation directory
print_info "Removing installation directory..."
rm -rf "$INSTALL_DIR"
print_success "Removed $INSTALL_DIR"

# Remove from shell config
for rc_file in "$HOME/.zshrc" "$HOME/.bashrc"; do
    if [ -f "$rc_file" ]; then
        if grep -q "git-commands/shell_integration.sh" "$rc_file"; then
            print_info "Cleaning $rc_file..."
            # Remove the source line and comment
            sed -i.bak '/# Git Command Templates/d' "$rc_file"
            sed -i.bak '/git-commands\/shell_integration.sh/d' "$rc_file"
            rm -f "$rc_file.bak"
            print_success "Cleaned $rc_file"
        fi
    fi
done

echo ""
print_success "Git Command Templates has been uninstalled."
echo ""
echo -e "${YELLOW}Please restart your terminal or run:${NC}"
echo -e "  ${CYAN}source ~/.zshrc${NC}  (or ~/.bashrc)"
echo ""
