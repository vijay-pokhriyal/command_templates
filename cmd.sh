#!/bin/bash

# =============================================================================
# Command Templates Runner (cmd.sh)
# A shortcut system for Git and Shell commands
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/commands.yaml"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Print colored output
print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }
print_cmd() { echo -e "${CYAN}→ $1${NC}"; }

# Show help
show_help() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║          COMMAND TEMPLATES - Quick Reference               ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}GIT COMMANDS:${NC}"
    echo -e "  ${CYAN}/add${NC}              Stage all changes"
    echo -e "  ${CYAN}/addf${NC} <file>      Stage a specific file"
    echo -e "  ${CYAN}/commit${NC} \"msg\"     Commit with message"
    echo -e "  ${CYAN}/acommit${NC} \"msg\"    Stage all and commit"
    echo -e "  ${CYAN}/amend${NC} \"msg\"      Amend last commit message"
    echo -e "  ${CYAN}/uncommit${NC}         Undo last commit (keep changes)"
    echo -e "  ${CYAN}/unstage${NC} [file]   Unstage file(s)"
    echo ""
    echo -e "  ${CYAN}/branch${NC}           List all branches"
    echo -e "  ${CYAN}/newbranch${NC} <name> Create and switch to branch"
    echo -e "  ${CYAN}/switch${NC} <name>    Switch to branch"
    echo -e "  ${CYAN}/delbranch${NC} <name> Delete local branch"
    echo ""
    echo -e "  ${CYAN}/push${NC} <branch>    Push to remote"
    echo -e "  ${CYAN}/pushu${NC} <branch>   Push and set upstream"
    echo -e "  ${CYAN}/publish${NC}          Publish current branch"
    echo -e "  ${CYAN}/pull${NC} <branch>    Pull from remote"
    echo -e "  ${CYAN}/fetch${NC}            Fetch all remotes"
    echo -e "  ${CYAN}/remote${NC}           View/add/remove remotes"
    echo ""
    echo -e "  ${CYAN}/status${NC}           Show git status"
    echo -e "  ${CYAN}/log${NC} <count>      Show recent commits"
    echo -e "  ${CYAN}/logg${NC} <count>     Show commit graph"
    echo -e "  ${CYAN}/diff${NC}             Show unstaged changes"
    echo -e "  ${CYAN}/diffs${NC}            Show staged changes"
    echo ""
    echo -e "  ${CYAN}/stash${NC} \"msg\"      Stash with message"
    echo -e "  ${CYAN}/stashlist${NC}        List stashes"
    echo -e "  ${CYAN}/stashpop${NC}         Pop latest stash"
    echo ""
    echo -e "  ${CYAN}/merge${NC} <branch>   Merge branch"
    echo -e "  ${CYAN}/rebase${NC} <branch>  Rebase onto branch"
        echo -e "  ${CYAN}/reset${NC}            Hard reset to HEAD"
    echo -e "  ${CYAN}/clean${NC}            Remove untracked files"
    echo ""
    echo -e "${YELLOW}WORKFLOWS (Multi-Command):${NC}"
    echo -e "  ${CYAN}/fresh${NC} <branch>            Fresh feature branch from main"
    echo -e "  ${CYAN}/ship${NC} \"msg\"             Stage, commit, rebase main, push"
    echo -e "  ${CYAN}/cleanup${NC}                  Remove stale/merged branches"
    echo -e "  ${CYAN}/rebasei${NC}                  Interactive rebase onto main"
    echo -e "  ${CYAN}/stash-pull-pop${NC}           Stash, pull/rebase, re-apply work"
    echo -e "  ${CYAN}/forcepush-safe${NC}           Backup branch, force-push safely"
    echo -e "  ${CYAN}/rescue-merge${NC}             Undo last merge/rebase (reflog)"
    echo -e "  ${CYAN}/sync${NC} <branch>             Fetch and rebase onto remote branch"
    echo ""
    echo -e "${YELLOW}USAGE:${NC}"
    echo -e "  ./cmd.sh /add"
    echo -e "  ./cmd.sh /commit \"your message here\""
    echo -e "  ./cmd.sh /ship \"feature done\" main"
    echo ""
}

# Execute git commands
execute_git_command() {
    local shortcut="$1"
    shift
    local args=("$@")

    case "$shortcut" in
        # Staging & Committing
        "/add")
            print_cmd "git add ."
            git add .
            print_success "All changes staged"
            ;;
        "/addf")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /addf <filename>"
                return 1
            fi
            print_cmd "git add ${args[0]}"
            git add "${args[0]}"
            print_success "Staged: ${args[0]}"
            ;;
        "/commit")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /commit \"message\""
                return 1
            fi
            print_cmd "git commit -m \"${args[0]}\""
            git commit -m "${args[0]}"
            ;;
        "/acommit")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /acommit \"message\""
                return 1
            fi
            print_cmd "git add . && git commit -m \"${args[0]}\""
            git add . && git commit -m "${args[0]}"
            ;;
        "/amend")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /amend \"message\""
                return 1
            fi
            print_cmd "git commit --amend -m \"${args[0]}\""
            git commit --amend -m "${args[0]}"
            ;;
        "/uncommit")
            print_cmd "git reset --soft HEAD~1"
            git reset --soft HEAD~1
            print_success "Last commit undone, changes kept staged"
            ;;
        "/unstage")
            if [ -z "${args[0]}" ]; then
                print_cmd "git restore --staged ."
                git restore --staged . 2>/dev/null || git reset HEAD -- . 2>/dev/null || git rm --cached -r . 2>/dev/null
                print_success "All files unstaged"
            else
                print_cmd "git restore --staged ${args[0]}"
                git restore --staged "${args[0]}" 2>/dev/null || git reset HEAD -- "${args[0]}" 2>/dev/null || git rm --cached "${args[0]}" 2>/dev/null
                print_success "Unstaged: ${args[0]}"
            fi
            ;;
        
        # Branching
        "/branch")
            print_cmd "git branch"
            git branch
            ;;
        "/newbranch")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /newbranch <branch-name>"
                return 1
            fi
            print_cmd "git checkout -b ${args[0]}"
            git checkout -b "${args[0]}"
            ;;
        "/switch")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /switch <branch-name>"
                return 1
            fi
            print_cmd "git checkout ${args[0]}"
            git checkout "${args[0]}"
            ;;
        "/delbranch")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /delbranch <branch-name>"
                return 1
            fi
            print_cmd "git branch -d ${args[0]}"
            git branch -d "${args[0]}"
            ;;
        "/delbranchf")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /delbranchf <branch-name>"
                return 1
            fi
            print_cmd "git branch -D ${args[0]}"
            git branch -D "${args[0]}"
            ;;
        
        # Remote Operations
        "/push")
            local branch="${args[0]:-$(git branch --show-current)}"
            print_cmd "git push origin $branch"
            git push origin "$branch"
            ;;
        "/pushf")
            local branch="${args[0]:-$(git branch --show-current)}"
            print_warning "Force pushing to $branch"
            print_cmd "git push origin $branch --force"
            git push origin "$branch" --force
            ;;
        "/pushu")
            local branch="${args[0]:-$(git branch --show-current)}"
            print_cmd "git push -u origin $branch"
            git push -u origin "$branch"
            ;;
        "/publish")
            # Check if remote origin exists
            if ! git remote | grep -q "origin"; then
                print_error "No remote 'origin' configured!"
                echo ""
                print_info "Set up a remote first:"
                echo -e "  ${CYAN}/remote add <url>${NC}"
                echo ""
                print_info "Example:"
                echo -e "  /remote add https://github.com/username/repo.git"
                return 1
            fi
            local branch="$(git branch --show-current)"
            print_cmd "git push -u origin $branch"
            git push -u origin "$branch"
            print_success "Published branch: $branch"
            ;;
        "/remote")
            if [ -z "${args[0]}" ]; then
                print_cmd "git remote -v"
                git remote -v
                if [ -z "$(git remote)" ]; then
                    echo ""
                    print_info "No remotes configured. Add one with:"
                    echo -e "  ${CYAN}/remote add <url>${NC}"
                fi
            elif [ "${args[0]}" = "add" ]; then
                if [ -z "${args[1]}" ]; then
                    print_error "Usage: /remote add <url>"
                    return 1
                fi
                print_cmd "git remote add origin ${args[1]}"
                git remote add origin "${args[1]}"
                print_success "Remote origin added: ${args[1]}"
            elif [ "${args[0]}" = "remove" ]; then
                print_cmd "git remote remove origin"
                git remote remove origin
                print_success "Remote origin removed"
            else
                print_error "Unknown option: ${args[0]}"
                echo "Usage: /remote [add <url> | remove]"
            fi
            ;;
        "/pull")
            local branch="${args[0]:-$(git branch --show-current)}"
            print_cmd "git pull origin $branch"
            # Handle divergent branches by using rebase
            git pull --rebase origin "$branch" 2>/dev/null || {
                # If rebase fails, try regular pull
                git pull origin "$branch" 2>&1 | grep -q "divergent" && {
                    print_warning "Divergent branches detected. Using rebase..."
                    git pull --rebase origin "$branch"
                } || git pull origin "$branch"
            }
            ;;
        "/fetch")
            print_cmd "git fetch --all"
            git fetch --all
            ;;
        
        # Status & Logs
        "/status")
            print_cmd "git status"
            git status
            ;;
        "/log")
            local count="${args[0]:-10}"
            print_cmd "git log --oneline -n $count"
            git log --oneline -n "$count"
            ;;
        "/logg")
            local count="${args[0]:-20}"
            print_cmd "git log --oneline --graph --all -n $count"
            git log --oneline --graph --all -n "$count"
            ;;
        "/diff")
            print_cmd "git diff"
            git diff
            ;;
        "/diffs")
            print_cmd "git diff --staged"
            git diff --staged
            ;;
        
        # Stashing
        "/stash")
            local msg="${args[0]:-WIP}"
            print_cmd "git stash push -m \"$msg\""
            git stash push -m "$msg"
            ;;
        "/stashlist")
            print_cmd "git stash list"
            git stash list
            ;;
        "/stashpop")
            print_cmd "git stash pop"
            git stash pop
            ;;
        "/stashapply")
            local index="${args[0]:-0}"
            print_cmd "git stash apply stash@{$index}"
            git stash apply "stash@{$index}"
            ;;
        
        # Merging & Rebasing
        "/merge")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /merge <branch-name>"
                return 1
            fi
            print_cmd "git merge ${args[0]}"
            git merge "${args[0]}"
            ;;
        "/rebase")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /rebase <branch-name>"
                return 1
            fi
            print_cmd "git rebase ${args[0]}"
            git rebase "${args[0]}"
            ;;
        "/rebasei")
            local count="${args[0]:-3}"
            print_cmd "git rebase -i HEAD~$count"
            git rebase -i HEAD~"$count"
            ;;
        "/abort")
            print_cmd "git merge --abort"
            git merge --abort
            ;;
        
        # Reset & Clean
        "/reset")
            print_warning "This will discard all local changes!"
            read -p "Are you sure? (y/N): " confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                print_cmd "git reset --hard HEAD"
                git reset --hard HEAD
            else
                print_info "Aborted"
            fi
            ;;
        "/clean")
            print_warning "This will remove all untracked files!"
            read -p "Are you sure? (y/N): " confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                print_cmd "git clean -fd"
                git clean -fd
            else
                print_info "Aborted"
            fi
            ;;
        "/restore")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /restore <filename>"
                return 1
            fi
            print_cmd "git restore ${args[0]}"
            git restore "${args[0]}"
            ;;
        
        # Clone & Init
        "/clone")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /clone <url>"
                return 1
            fi
            print_cmd "git clone ${args[0]}"
            git clone "${args[0]}"
            ;;
        "/init")
            print_cmd "git init"
            git init
            print_success "Git repository initialized"
            ;;
        
        *)
            return 1
            ;;
    esac
    return 0
}

# Execute workflow commands
execute_workflow() {
    local shortcut="$1"
    shift
    local args=("$@")

    case "$shortcut" in
        "/sync")
            local branch="${args[0]:-$(git branch --show-current)}"
            print_info "Syncing with remote..."
            print_cmd "git fetch --all"
            git fetch --all
            print_cmd "git pull --rebase origin $branch"
            git pull --rebase origin "$branch" 2>/dev/null || {
                print_warning "Rebase failed, trying merge..."
                git pull origin "$branch"
            }
            print_success "Synced with $branch"
            ;;
        "/ship")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /ship \"message\" [branch]"
                return 1
            fi
            local message="${args[0]}"
            local branch="${args[1]:-$(git branch --show-current)}"
            print_info "Shipping changes..."
            print_cmd "git add ."
            git add .
            print_cmd "git commit -m \"$message\""
            git commit -m "$message"
            print_cmd "git push origin $branch"
            git push origin "$branch"
            print_success "Changes shipped to $branch!"
            ;;
        "/fresh")
            if [ -z "${args[0]}" ]; then
                print_error "Usage: /fresh <new-branch-name>"
                return 1
            fi
            local new_branch="${args[0]}"
            print_info "Creating fresh branch from main..."
            print_cmd "git checkout main"
            git checkout main
            print_cmd "git pull origin main"
            git pull origin main
            print_cmd "git checkout -b $new_branch"
            git checkout -b "$new_branch"
            print_success "Created fresh branch: $new_branch"
            ;;
        "/cleanup")
            print_info "Cleaning up stale and merged branches..."
            print_cmd "git fetch --prune"
            git fetch --prune
            print_cmd "git branch -vv | grep ': gone]' | awk '{print \$1}' | xargs -r git branch -d"
            git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -d
            print_cmd "git branch --merged | grep -v '*' | grep -v 'main' | xargs -r git branch -d"
            git branch --merged | grep -v '*' | grep -v 'main' | xargs -r git branch -d
            print_success "Cleanup complete."
            ;;
        "/stash-pull-pop")
            print_info "Stashing, pulling with rebase, and popping stash..."
            print_cmd "git stash push -m 'auto-stash before pull'"
            git stash push -m 'auto-stash before pull'
            print_cmd "git pull --rebase origin $(git branch --show-current)"
            git pull --rebase origin "$(git branch --show-current)"
            print_cmd "git stash pop"
            git stash pop
            print_success "Stash applied after pull."
            ;;
        "/forcepush-safe")
            local branch="$(git branch --show-current)"
            print_info "Backing up branch and force-pushing with lease..."
            print_cmd "git branch backup-$(date +%Y%m%d%H%M%S)"
            git branch backup-$(date +%Y%m%d%H%M%S)
            print_cmd "git push --force-with-lease origin $branch"
            git push --force-with-lease origin "$branch"
            print_success "Force-pushed with backup."
            ;;
        "/rescue-merge")
            print_info "Undoing last merge/rebase using reflog..."
            print_cmd "git reflog"
            git reflog
            print_cmd "git reset --hard HEAD@{1}"
            git reset --hard HEAD@{1}
            print_success "Rescue complete."
            ;;
        *)
            return 1
            ;;
    esac
    return 0
}

# Main execution
main() {
    if [ $# -eq 0 ] || [ "$1" == "/help" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        show_help
        return 0
    fi

    local shortcut="$1"
    shift

    # Try git commands first
    if execute_git_command "$shortcut" "$@"; then
        return 0
    fi

    # Try workflows
    if execute_workflow "$shortcut" "$@"; then
        return 0
    fi

    # Unknown command
    print_error "Unknown command: $shortcut"
    print_info "Use /help to see available commands"
    return 1
}

main "$@"
