# Git Command Templates 🚀

> **Type `/add` instead of `git add .`** — A shortcut system for Git commands to boost your productivity.

[![Made for ZSH](https://img.shields.io/badge/Shell-ZSH-green.svg)](https://www.zsh.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## ⚡ For Developers: Get Started in 30 Seconds

### Step 1: Install (one command)
```bash
curl -fsSL https://raw.githubusercontent.com/vijay-pokhriyal/command_templates/master/remote_install.sh | bash
```

### Step 2: Activate (choose one)
```bash
# Option A: Reload your shell
source ~/.git-commands/shell_integration.sh

# Option B: Or just open a new terminal window
```

### Step 3: Start using!
```bash
/help                   # See all available commands
```

That's it! ✅

---

## 🎯 Why Use This?

| Instead of typing... | Just type... |
|---------------------|--------------|
| `git add .` | `/add` |
| `git commit -m "message"` | `/commit "message"` |
| `git add . && git commit -m "msg" && git push` | `/ship "msg"` |
| `git checkout -b feature-x` | `/newbranch feature-x` |
| `git log --oneline -10` | `/log 10` |

**Save 50+ keystrokes per Git operation!**

---

## 🔧 Alternative Installation Methods

### Clone & Install Locally
```bash
git clone https://github.com/vijay-pokhriyal/command_templates.git
cd command_templates
./install.sh
source ~/.git-commands/shell_integration.sh
```

### Manual Installation
```bash
# 1. Download files to ~/.git-commands/
mkdir -p ~/.git-commands
curl -fsSL https://raw.githubusercontent.com/vijay-pokhriyal/command_templates/master/cmd.sh > ~/.git-commands/cmd.sh
curl -fsSL https://raw.githubusercontent.com/vijay-pokhriyal/command_templates/master/shell_integration.sh > ~/.git-commands/shell_integration.sh
chmod +x ~/.git-commands/cmd.sh

# 2. Add to your ~/.zshrc
echo 'source ~/.git-commands/shell_integration.sh' >> ~/.zshrc

# 3. Activate
source ~/.zshrc
```

---

## 🗑️ Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/vijay-pokhriyal/command_templates/master/uninstall.sh | bash
```

Or manually:
```bash
rm -rf ~/.git-commands
# Remove the 'source ~/.git-commands/shell_integration.sh' line from ~/.zshrc
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
| `/remote` | View/add/remove remotes | `/remote`, `/remote add <url>` |

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

**Share with your team in one message:**

```
# Install Git Command Templates (saves typing for common git operations)
curl -fsSL https://raw.githubusercontent.com/vijay-pokhriyal/command_templates/master/remote_install.sh | bash
source ~/.git-commands/shell_integration.sh

# Then type /help to see all commands
```

**Each developer runs the above and they're ready!**

---

## 🔍 Troubleshooting

### Commands not working after install?
```bash
# Make sure it's sourced
source ~/.git-commands/shell_integration.sh

# Or open a new terminal
```

### Check if installed correctly
```bash
# Should show the help menu
/help

# Check if files exist
ls -la ~/.git-commands/
```

### Still not working?
```bash
# Check your ~/.zshrc has this line:
grep "git-commands" ~/.zshrc

# If missing, add it:
echo 'source ~/.git-commands/shell_integration.sh' >> ~/.zshrc
source ~/.zshrc
```

---

## 📁 File Structure

```
~/.git-commands/           # Installation directory
├── cmd.sh                 # Main executable with all commands
├── shell_integration.sh   # ZSH integration (creates aliases)
└── commands.yaml          # Command reference (optional)
```

---

## 💡 Pro Tips

| Tip | Example |
|-----|---------|
| Commands use current branch by default | `/push` pushes current branch |
| Destructive commands ask confirmation | `/reset`, `/clean` require `y` to proceed |
| Chain with shell commands | `/add && /commit "msg"` works! |
| See what a command does | Check `/help` or `commands.yaml` |

---

## 🤝 Contributing

1. Fork the repository
2. Add your command to `cmd.sh`
3. Update `commands.yaml` and `README.md`
4. Submit a pull request

---

## 📝 License

MIT - Free to use and modify!

---

**Made with ❤️ to save developers from typing `git add . && git commit -m "message" && git push` ever again.**
