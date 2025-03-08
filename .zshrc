# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)


source $ZSH/oh-my-zsh.sh

source ~/.zsh_bindkey

export PATH="$PATH:/home/ikqxzi/.dotnet"

# File to store transparency state
TRANSPARENCY_STATE_FILE="$HOME/.transparency_state"

# Function to toggle transparency
toggle_transparency() {
    # Default state
    if [[ ! -f "$TRANSPARENCY_STATE_FILE" ]]; then
        echo "opaque" > "$TRANSPARENCY_STATE_FILE"
    fi

    # Read the current state
    local current_state
    current_state=$(cat "$TRANSPARENCY_STATE_FILE")

    # Determine the next state
    local next_state terminal_opacity
    if [[ "$current_state" == "opaque" ]]; then
        next_state="transparent"
        terminal_opacity=30
    else
        next_state="opaque"
        terminal_opacity=0
    fi

    # Update terminal transparency (GNOME Terminal example)
    local profile
    profile=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
    dconf write /org/gnome/terminal/legacy/profiles:/:$profile/background-transparency-percent "$terminal_opacity"

    # Save the next state
    echo "$next_state" > "$TRANSPARENCY_STATE_FILE"

    # Return the new state
    echo "$next_state"
}


# system aliases
alias cl="clear"
# map cd to cd & ls


# config & sourcing [nvim, zsh]
alias nvc="cd ~/.config/nvim && nvim init.lua"
alias nvs='nvim --headless -c "luafile $HOME/.config/nvim/init.lua" -c "qa"'
alias zshc="nvim ~/.zshrc"
alias zshs="source ~/.zshrc"


# coding stuff

# code execution
alias dnr="~/coding/dotnetrun.sh"
alias pyr="~/coding/pyrun.sh"

cod() {
  cd ~/coding
  if [ -n "$1" ]; then
    cd "$1"
  fi
  ls
}

# notes
nt() {
  cd ~/coding/notes
  if [ -n "$1" ]; then
    nvim "$1"
  fi
  ls
}

c#() {
  cd ~/coding/c#
  if [ -n "$1" ]; then
    cd "$1"
  fi
  ls
}

py() {
  cd ~/coding/python
  if [ -n "$1" ]; then
    cd "$1"
  fi
  ls
}

pyp() {
  cd ~/.venv/nvim/bin/ && source activate
  pip "$@"
  deactivate && cd -
}


# SSH stuff
# Start SSH agent if not running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

# Add SSH key (only if not already added)
alias ssha="ssh-add ~/.ssh/id_rsa"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
