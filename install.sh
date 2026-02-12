#!/bin/bash

# =============================================================================
# Git Command Templates - Installer
# One command to install git shortcuts for your team
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }
print_step() { echo -e "${CYAN}→ $1${NC}"; }

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║       Git Command Templates - Installation                 ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Default installation directory
INSTALL_DIR="$HOME/.git-commands"
SHELL_RC=""

# Detect shell
detect_shell() {
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_RC="$HOME/.zshrc"
        SHELL_NAME="zsh"
    elif [ -n "$BASH_VERSION" ]; then
        SHELL_RC="$HOME/.bashrc"
        SHELL_NAME="bash"
    elif [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
        SHELL_NAME="zsh"
    elif [ -f "$HOME/.bashrc" ]; then
        SHELL_RC="$HOME/.bashrc"
        SHELL_NAME="bash"
    else
        SHELL_RC="$HOME/.zshrc"
        SHELL_NAME="zsh"
    fi
}

# Check if already installed
check_existing() {
    if [ -d "$INSTALL_DIR" ]; then
        print_info "Existing installation found at $INSTALL_DIR"
        read -p "Do you want to update/reinstall? (y/N): " confirm
        if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
            echo "Installation cancelled."
            exit 0
        fi
        rm -rf "$INSTALL_DIR"
    fi
}

# Create installation directory
install_files() {
    print_step "Creating installation directory..."
    mkdir -p "$INSTALL_DIR"
    
    print_step "Copying files..."
    
    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Copy files
    cp "$SCRIPT_DIR/cmd.sh" "$INSTALL_DIR/"
    cp "$SCRIPT_DIR/commands.yaml" "$INSTALL_DIR/"
    cp "$SCRIPT_DIR/README.md" "$INSTALL_DIR/"
    
    # Create shell integration file with correct path
    cat > "$INSTALL_DIR/shell_integration.sh" << 'SHELL_INTEGRATION'
#!/bin/bash

# =============================================================================
# Git Command Templates - Shell Integration
# =============================================================================

export GIT_CMD_PATH="$HOME/.git-commands"

# Main command alias
alias cmd="$GIT_CMD_PATH/cmd.sh"

# Git shortcuts (no arguments)
alias '/add'='cmd /add'
alias '/status'='cmd /status'
alias '/branch'='cmd /branch'
alias '/fetch'='cmd /fetch'
alias '/log'='cmd /log'
alias '/diff'='cmd /diff'
alias '/diffs'='cmd /diffs'
alias '/stashlist'='cmd /stashlist'
alias '/stashpop'='cmd /stashpop'
alias '/uncommit'='cmd /uncommit'
alias '/init'='cmd /init'

# Git functions (with arguments)
/unstage() { cmd /unstage "$@"; }
/commit() { cmd /commit "$@"; }
/acommit() { cmd /acommit "$@"; }
/amend() { cmd /amend "$@"; }
/addf() { cmd /addf "$@"; }
/newbranch() { cmd /newbranch "$@"; }
/switch() { cmd /switch "$@"; }
/delbranch() { cmd /delbranch "$@"; }
/delbranchf() { cmd /delbranchf "$@"; }
/push() { cmd /push "$@"; }
/pushf() { cmd /pushf "$@"; }
/pushu() { cmd /pushu "$@"; }
/publish() { cmd /publish "$@"; }
/remote() { cmd /remote "$@"; }
/pull() { cmd /pull "$@"; }
/logg() { cmd /logg "$@"; }
/stash() { cmd /stash "$@"; }
/stashapply() { cmd /stashapply "$@"; }
/merge() { cmd /merge "$@"; }
/rebase() { cmd /rebase "$@"; }
/rebasei() { cmd /rebasei "$@"; }
/abort() { cmd /abort "$@"; }
/reset() { cmd /reset "$@"; }
/clean() { cmd /clean "$@"; }
/restore() { cmd /restore "$@"; }
/clone() { cmd /clone "$@"; }

# Workflow functions
/sync() { cmd /sync "$@"; }
/ship() { cmd /ship "$@"; }
/fresh() { cmd /fresh "$@"; }
/cleanup() { cmd /cleanup "$@"; }

# Help
/help() { cmd /help; }

echo -e "\033[0;32m✓ Git Command Templates loaded! Type /help for commands.\033[0m"
SHELL_INTEGRATION

    # Make executable
    chmod +x "$INSTALL_DIR/cmd.sh"
    chmod +x "$INSTALL_DIR/shell_integration.sh"
    
    print_success "Files installed to $INSTALL_DIR"
}

# Add to shell config
configure_shell() {
    print_step "Configuring $SHELL_NAME..."
    
    # Check if already configured
    if grep -q "git-commands/shell_integration.sh" "$SHELL_RC" 2>/dev/null; then
        print_info "Shell already configured"
    else
        echo "" >> "$SHELL_RC"
        echo "# Git Command Templates" >> "$SHELL_RC"
        echo "source \"\$HOME/.git-commands/shell_integration.sh\"" >> "$SHELL_RC"
        print_success "Added to $SHELL_RC"
    fi
}

# Show completion message
show_complete() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              Installation Complete! 🎉                     ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}Quick Start:${NC}"
    echo -e "  ${CYAN}/help${NC}              Show all commands"
    echo -e "  ${CYAN}/add${NC}               Stage all changes"
    echo -e "  ${CYAN}/commit \"msg\"${NC}      Commit with message"
    echo -e "  ${CYAN}/ship \"msg\"${NC}        Stage, commit & push"
    echo ""
    echo -e "${YELLOW}Documentation:${NC} $INSTALL_DIR/README.md"
    echo ""
}

# Restart shell to load commands
restart_shell() {
    echo ""
    echo -e "${YELLOW}To activate commands, either:${NC}"
    echo -e "  1. Run: ${CYAN}source ~/.git-commands/shell_integration.sh${NC}"
    echo -e "  2. Open a new terminal"
    echo ""
    read -p "$(echo -e "${YELLOW}Or restart shell now? (Y/n): ${NC}")" confirm
    if [[ ! "$confirm" =~ ^[Nn]$ ]]; then
        print_success "Starting new shell session..."
        echo ""
        exec $SHELL -l
    fi
}

# Main installation
main() {
    detect_shell
    check_existing
    install_files
    configure_shell
    show_complete
    restart_shell
}

main "$@"
