# Command Templates 🚀

A shortcut system for Git and Shell commands to boost your team's productivity.

## Quick Start

### 1. Make the script executable
```bash
chmod +x ~/Desktop/data_central/command_templates/cmd.sh
```

### 2. Use directly
```bash
./cmd.sh /add                    # Stage all changes
./cmd.sh /commit "fix: bug"      # Commit with message
./cmd.sh /ship "done" main       # Stage, commit, push
```

### 3. (Recommended) Add to your shell
Add this line to your `~/.zshrc`:
```bash
source ~/Desktop/data_central/command_templates/zsh_integration.sh
```

Then reload:
```bash
source ~/.zshrc
```

Now you can use shortcuts directly:
```bash
/add                    # Stage all changes
/commit "fix: bug"      # Commit with message
/ship "done" main       # Stage, commit, push
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

### Shell Commands

#### Navigation
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/ls` | List files with details | `/ls` |
| `/cd` | Change directory | `/cd ~/projects` |
| `/pwd` | Print working directory | `/pwd` |
| `/back` | Go to parent directory | `/back` |

#### File Operations
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/mk` | Create directory | `/mk new-folder` |
| `/touch` | Create empty file | `/touch newfile.txt` |
| `/rm` | Remove file/directory (⚠️) | `/rm old-folder` |
| `/cp` | Copy files | `/cp src dest` |
| `/mv` | Move/rename files | `/mv old.txt new.txt` |

#### Search
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/find` | Find files by name | `/find "*.js"` |
| `/grep` | Search text in files | `/grep "TODO"` |

#### Process Management
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/ps` | Find processes | `/ps node` |
| `/kill` | Kill process | `/kill 12345` |
| `/port` | Find process on port | `/port 3000` |

#### System Info
| Shortcut | Description | Usage |
|----------|-------------|-------|
| `/disk` | Show disk usage | `/disk` |
| `/size` | Show directory size | `/size ./node_modules` |
| `/ip` | Get public IP | `/ip` |
| `/ping` | Ping host | `/ping google.com` |
| `/env` | Show environment variable | `/env PATH` |

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
2. **Confirmations**: Destructive commands (`/reset`, `/clean`, `/rm`) ask for confirmation
3. **Colored output**: Commands show status with colors for easy reading
4. **Help**: Type `/help` or `cmd /help` to see quick reference

---
**source /Users/vijaypokhriyal/Desktop/data_central/command_templates/zsh_integration.sh && /help**

## License

MIT - Free to use and modify for your team!
