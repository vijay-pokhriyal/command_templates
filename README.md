# Git Command Templates 🚀

A shortcut system for Git commands to boost your team's productivity.

## 🚀 One-Line Installation

### Install via curl (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/vijay-pokhriyal/command_templates/master/remote_install.sh | bash
```

### Or clone and install locally
```bash
git clone https://github.com/vijay-pokhriyal/command_templates.git
cd command_templates
./install.sh
```

Then restart your terminal or run:
```bash
source ~/.zshrc
```

## ✨ Quick Start

```bash
/help                   # Show all commands
/add                    # Stage all changes
/commit "fix: bug"      # Commit with message
/ship "done"            # Stage, commit & push
```

## 🗑️ Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/vijay-pokhriyal/command_templates/master/uninstall.sh | bash
```

---

## 📋 Available Commands

### Git Commands

| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/add` | Stage all changes | `/add` |
| `/addf` | Stage specific file | `/addf filename.txt` |
| `/commit` | Commit with message | `/commit "your message"` |
| `/acommit` | Stage all & commit | `/acommit "your message"` |
| `/amend` | Amend last commit | `/amend "new message"` |
| `/uncommit` | Undo last commit (keep changes) | `/uncommit` |
| `/unstage` | Unstage file(s) | `/unstage [filename]` |

#### Branching
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/branch` | List all branches | `/branch` |
| `/newbranch` | Create & switch to branch | `/newbranch feature-xyz` |
| `/switch` | Switch to branch | `/switch main` |
| `/delbranch` | Delete local branch | `/delbranch old-branch` |
| `/delbranchf` | Force delete branch | `/delbranchf old-branch` |

#### Remote Operations
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/push` | Push to remote | `/push main` |
| `/pushf` | Force push | `/pushf feature-branch` |
| `/pushu` | Push & set upstream | `/pushu new-branch` |
| `/publish` | Publish current branch | `/publish` |
| `/pull` | Pull from remote | `/pull main` |
| `/fetch` | Fetch all remotes | `/fetch` |

#### Status & Logs
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/status` | Show git status | `/status` |
| `/log` | Show recent commits | `/log 10` |
| `/logg` | Show commit graph | `/logg 20` |
| `/diff` | Show unstaged changes | `/diff` |
| `/diffs` | Show staged changes | `/diffs` |

#### Stashing
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/stash` | Stash with message | `/stash "work in progress"` |
| `/stashlist` | List all stashes | `/stashlist` |
| `/stashpop` | Pop latest stash | `/stashpop` |
| `/stashapply` | Apply specific stash | `/stashapply 0` |

#### Merging & Rebasing
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/merge` | Merge branch | `/merge feature-branch` |
| `/rebase` | Rebase onto branch | `/rebase main` |
| `/rebasei` | Interactive rebase | `/rebasei 3` |
| `/abort` | Abort merge | `/abort` |

#### Reset & Clean
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/reset` | Hard reset (⚠️ destructive) | `/reset` |
| `/clean` | Remove untracked files (⚠️ destructive) | `/clean` |
| `/restore` | Discard file changes | `/restore filename.txt` |

#### Repository
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/clone` | Clone repository | `/clone https://github.com/user/repo` |
| `/init` | Initialize new repo | `/init` |

---

### Workflows (Multi-Command)

| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/sync` | Fetch & pull latest | `/sync main` |
| `/ship` | Stage, commit, push | `/ship "message" main` |
| `/fresh` | New branch from main | `/fresh feature-new` |
| `/cleanup` | Remove stale branches | `/cleanup` |

---

## 🎨 Adding Custom Commands

Edit `commands.yaml` to add your own shortcuts:

```yaml
git_commands:
  /mycommand:
    command: "git your-command here"
    description: "What it does"
    usage: "/mycommand <args>"
```

Then add the implementation in `cmd.sh`.

---

## 👥 Team Setup

Share these files with your team:
1. `cmd.sh` - Main script
2. `zsh_integration.sh` - Shell integration
3. `commands.yaml` - Configuration reference
4. `README.md` - This documentation

Each team member should:
1. Clone/copy the files to their machine
2. Update the path in `zsh_integration.sh`
3. Add `source` line to their `~/.zshrc`
4. Reload shell with `source ~/.zshrc`

---

## 📁 File Structure

```
command_templates/
├── cmd.sh              # Main executable script
├── commands.yaml       # Command configuration/reference
├── zsh_integration.sh  # ZSH shell integration
└── README.md           # This file
```

---

## 💡 Tips

1. **Default branch**: Commands like `/push`, `/pull`, `/sync` use current branch if not specified
2. **Confirmations**: Destructive commands (`/reset`, `/clean`) ask for confirmation
3. **Colored output**: Commands show status with colors for easy reading
4. **Help**: Type `/help` or `cmd /help` to see quick reference

---

## License

MIT - Free to use and modify for your team!
