#!/bin/bash

# =============================================================================
# Git Command Templates - Remote Installer
# Run with: curl -fsSL https://raw.githubusercontent.com/vijay-pokhriyal/command_templates/master/remote_install.sh | bash
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

REPO_URL="https://raw.githubusercontent.com/vijay-pokhriyal/command_templates/master"
INSTALL_DIR="$HOME/.git-commands"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║       Git Command Templates - Remote Installation          ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Detect shell
detect_shell() {
    if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
        SHELL_NAME="zsh"
    else
        SHELL_RC="$HOME/.bashrc"
        SHELL_NAME="bash"
    fi
}

# Check for existing installation
check_existing() {
    if [ -d "$INSTALL_DIR" ]; then
        print_info "Existing installation found. Updating..."
        rm -rf "$INSTALL_DIR"
    fi
}

# Download and install
install_files() {
    print_step "Creating installation directory..."
    mkdir -p "$INSTALL_DIR"
    
    print_step "Downloading files..."
    
    # Download main script
    curl -fsSL "$REPO_URL/cmd.sh" -o "$INSTALL_DIR/cmd.sh"
    print_success "Downloaded cmd.sh"
    
    # Download config
    curl -fsSL "$REPO_URL/commands.yaml" -o "$INSTALL_DIR/commands.yaml"
    print_success "Downloaded commands.yaml"
    
    # Download readme
    curl -fsSL "$REPO_URL/README.md" -o "$INSTALL_DIR/README.md"
    print_success "Downloaded README.md"
    
    # Create shell integration
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

# Configure shell
configure_shell() {
    print_step "Configuring $SHELL_NAME..."
    
    if grep -q "git-commands/shell_integration.sh" "$SHELL_RC" 2>/dev/null; then
        print_info "Shell already configured"
    else
        echo "" >> "$SHELL_RC"
        echo "# Git Command Templates" >> "$SHELL_RC"
        echo "source \"\$HOME/.git-commands/shell_integration.sh\"" >> "$SHELL_RC"
        print_success "Added to $SHELL_RC"
    fi
}

# Show completion
show_complete() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              Installation Complete! 🎉                     ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${RED}⚠️  ONE MORE STEP REQUIRED:${NC}"
    echo ""
    echo -e "  Run this command to activate (copy & paste):${NC}"
    echo ""
    echo -e "    ${GREEN}source ~/.git-commands/shell_integration.sh${NC}"
    echo ""
    echo -e "  ${YELLOW}(Or just open a new terminal tab/window)${NC}"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}Quick Start (after activation):${NC}"
    echo -e "  ${CYAN}/help${NC}              Show all commands"
    echo -e "  ${CYAN}/add${NC}               Stage all changes"
    echo -e "  ${CYAN}/commit \"msg\"${NC}      Commit with message"
    echo -e "  ${CYAN}/ship \"msg\"${NC}        Stage, commit & push"
    echo ""
}

# Main
main() {
    detect_shell
    check_existing
    install_files
    configure_shell
    show_complete
}

main "$@"
