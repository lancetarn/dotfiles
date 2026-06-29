# Brewfile — packages to install on a fresh machine via `brew bundle`.
#
# This lists only packages installed *directly* (on request) — Homebrew
# resolves and installs transitive dependencies automatically. Regenerate
# the "direct installs" set any time with:  ./brew-dump.sh
#
# Install everything with:  brew bundle --file=Brewfile
# (or just run ./bootstrap.sh, which calls it)

# --- Taps -------------------------------------------------------------------
tap "ngrok/ngrok"
tap "scoutapp/tap"

# --- Formulae (CLI tools & languages) ---------------------------------------
brew "automake"              # Tool for generating GNU Standards-compliant Makefiles
brew "awscli"                # Official Amazon AWS command-line interface
brew "bat"                   # Clone of cat(1) with syntax highlighting and Git integration
brew "datasette"             # Open source multi-tool for exploring and publishing data
brew "direnv"                # Load/unload environment variables based on $PWD
brew "docker"                # Pack, ship and run any application as a lightweight container
brew "docutils"              # Text processing system for reStructuredText
brew "fd"                    # Simple, fast and user-friendly alternative to find
brew "fzf"                   # Command-line fuzzy finder written in Go
brew "gh"                    # GitHub command-line tool
brew "git"                   # Distributed revision control system
brew "git-delta"             # Syntax-highlighting pager for git and diff output
brew "glab"                  # Open-source GitLab command-line tool
brew "gnupg"                 # GNU Privacy Guard (OpenPGP)
brew "go"                    # Open source programming language (simple/reliable/efficient)
brew "graphviz"              # Graph visualization software from AT&T and Bell Labs
brew "gron"                  # Make JSON greppable
brew "guile"                 # GNU Ubiquitous Intelligent Language for Extensions
brew "helix"                 # Post-modern modal text editor
brew "helm"                  # Kubernetes package manager
brew "httpie"                # User-friendly cURL replacement (command-line HTTP client)
brew "hugo"                  # Configurable static site generator
brew "jello"                 # Filter JSON and JSON Lines data with Python syntax
brew "jq"                    # Lightweight and flexible command-line JSON processor
brew "k9s"                   # Kubernetes CLI to manage your clusters in style
brew "kerl"                  # Easy building and installing of Erlang/OTP instances
brew "keyring"               # Access the system keyring service from Python
brew "kubectx"               # Switch between kubectl contexts easily and create aliases
brew "kubernetes-cli@1.22"   # Kubernetes command-line interface (pinned 1.22)
brew "mailpit", restart_service: :changed  # Web and API based SMTP testing
brew "mcp-publisher"         # Publisher CLI for the Model Context Protocol (MCP) Registry
brew "midnight-commander"    # Terminal-based visual file manager
brew "moor"                  # Nice to use pager for humans
brew "mtr"                   # 'traceroute' and 'ping' in a single tool
brew "neovim"                # Ambitious Vim-fork focused on extensibility and agility
brew "nmap"                  # Port scanning utility for large networks
brew "nvm"                   # Manage multiple Node.js versions
brew "openssl@1.1"           # Cryptography and SSL/TLS Toolkit
brew "openvpn"               # SSL/TLS VPN implementing OSI layer 2 or 3 secure network
brew "pandoc"                # Swiss-army knife of markup format conversion
brew "peco"                  # Simplistic interactive filtering tool
brew "php"                   # General-purpose scripting language
brew "pipx"                  # Execute binaries from Python packages in isolated environments
brew "pnpm"                  # Fast, disk space efficient package manager
brew "pre-commit"            # Framework for managing multi-language pre-commit hooks
brew "pyenv-virtualenv"      # Pyenv plugin to manage virtualenv
brew "python@3.10"           # Python 3.10
brew "python@3.9"            # Python 3.9
brew "rbenv"                 # Ruby version manager
brew "rich-cli"              # Command-line toolbox for fancy output in the terminal
brew "rtmpdump"              # Tool for downloading RTMP streaming media
brew "scc"                   # Fast, accurate code counter with complexity/COCOMO estimates
brew "sd"                    # Intuitive find & replace CLI
brew "semgrep"               # Detect and prevent bugs and anti-patterns in your codebase
brew "sevenzip"              # 7-Zip file archiver with a high compression ratio
brew "solargraph"            # Ruby language server
brew "spotify-tui"           # Terminal-based client for Spotify
brew "steampipe"             # Use SQL to instantly query your cloud services
brew "tesseract"             # OCR (Optical Character Recognition) engine
brew "the_silver_searcher"   # Code-search similar to ack
brew "tmux"                  # Terminal multiplexer
brew "tree"                  # Display directories as trees
brew "trufflehog"            # Find and verify credentials
brew "universal-ctags"       # Maintained ctags implementation
brew "uv"                    # Extremely fast Python package installer/resolver (Rust)
brew "virtualenv"            # Tool for creating isolated virtual python environments
brew "watch"                 # Execute a program periodically, showing output fullscreen
brew "watchman"              # Watch files and take action when they change
brew "yarn"                  # JavaScript package manager
brew "ykman"                 # Tool for managing your YubiKey configuration
brew "yq"                    # Process YAML, JSON, XML, CSV and properties from the CLI
brew "zlib"                  # General-purpose lossless data-compression library

# --- Casks (GUI apps & binaries) --------------------------------------------
cask "blackhole-16ch"            # Virtual audio driver (16 channels)
cask "blackhole-2ch"             # Virtual audio driver (2 channels)
cask "codex"                     # OpenAI's coding agent that runs in your terminal
cask "ngrok"                     # Reverse proxy / secure tunnels to localhost
cask "openvpn-connect"           # Client program for the OpenVPN Access Server
cask "scoutapp/tap/scout-cli"    # Scout APM CLI — monitor app performance from the terminal

# ============================================================================
# OPTIONAL — uncomment what you want, then re-run ./brew-install.sh
# ============================================================================
# These were taps/tools present on the old machine but NOT currently installed
# (or installed outside Homebrew). They are kept here as a checklist so they're
# easy to remember and selectively reinstall. `brew bundle` ignores comments.

# --- Taps that were configured but had no installed formulae ----------------
# tap "aws/tap"
# tap "dart-lang/dart"
# tap "go-task/tap"
# tap "hashicorp/tap"
# tap "sachaos/todoist"
# tap "sass/sass"
# tap "stripe/stripe-cli"
# tap "tylerbrock/saw"

# --- Tap formulae (CLI tools from the taps above) ---------------------------
# brew "aws/tap/aws-ddbsh"              # Amazon DynamoDB shell
# brew "dart-lang/dart/dart"            # Dart SDK
# brew "go-task/tap/go-task"            # Task runner / Make alternative
# brew "hashicorp/tap/terraform"       # Infrastructure as code
# brew "sass/sass/sass"                # Sass CSS preprocessor
# brew "stripe/stripe-cli/stripe"      # Stripe CLI
# brew "tylerbrock/saw/saw"            # Fast, multi-purpose AWS CloudWatch Logs tool

# --- Cross-language tools (need the relevant toolchain: go/uv/cargo/npm) -----
# Go dev tooling (mostly the vim-go binaries). Requires `go` (installed above).
# go "github.com/klauspost/asmfmt/cmd/asmfmt"
# go "github.com/go-delve/delve/cmd/dlv"               # Go debugger
# go "github.com/kisielk/errcheck"
# go "github.com/davidrjenni/reftools/cmd/fillstruct"
# go "github.com/rogpeppe/godef"
# go "golang.org/x/tools/cmd/goimports"
# go "github.com/golangci/golangci-lint/cmd/golangci-lint"
# go "github.com/fatih/gomodifytags"
# go "golang.org/x/tools/gopls"                        # Go language server
# go "golang.org/x/tools/cmd/gorename"
# go "github.com/jstemmer/gotags"
# go "golang.org/x/tools/cmd/guru"
# go "github.com/koron/iferr"
# go "github.com/josharian/impl"
# go "honnef.co/go/tools/cmd/keyify"
# go "github.com/fatih/motion"
# go "github.com/mgechev/revive"
# go "honnef.co/go/tools/cmd/staticcheck"
# go "golang.org/dl/go1.10.7"                          # Legacy Go version downloader
# go "github.com/sachaos/todoist"                      # Todoist CLI
# go "github.com/wailsapp/wails/v2/cmd/wails"          # Wails (Go+web desktop apps)

# Scout-internal Go services — PRIVATE repos, need VPN/SSH auth to install.
# go "github.com/scoutapp/apm_ingestion/archivist"
# go "github.com/scoutapp/apm_ingestion/delve"
# go "github.com/scoutapp/apm_ingestion/error_receiver"
# go "github.com/scoutapp/apm_ingestion/goin"
# go "github.com/scoutapp/apm_ingestion/mirror_maker"
# go "github.com/scoutapp/apm_ingestion/node_aggregator"
# go "github.com/scoutapp/apm_ingestion/retries"
# go "github.com/scoutapp/apm_ingestion/tiny"

# Python tools via uv (requires `uv`, installed above).
# uv "ipython"
# uv "spec-kitty-cli"
# uv "sqlite-utils"

# Rust tools via cargo (requires a Rust toolchain — `brew install rust` or rustup).
# cargo "cargo-generate"
# cargo "wasm-gc"

# Node tools via npm (requires node — install via nvm, which is in the list above).
# npm "corepack"
