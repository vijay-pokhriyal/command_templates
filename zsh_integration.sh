#!/bin/zsh

# =============================================================================
# Command Templates - ZSH Integration
# Add this to your ~/.zshrc for global access
# =============================================================================

# Set the path to your command templates
export CMD_TEMPLATES_PATH="$HOME/Desktop/data_central/command_templates"

# Create an alias for the main command
alias cmd="$CMD_TEMPLATES_PATH/cmd.sh"

# =============================================================================
# Direct shortcuts (optional - for even faster access)
# These create direct functions so you can type: /add instead of: cmd /add
# =============================================================================

# Git shortcuts
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

# Functions for commands that need arguments
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

echo "✓ Command Templates loaded! Type /help for commands."
