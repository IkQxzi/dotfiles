#!/bin/bash

shopt -s nocasematch # easier y/n comparison

read -p 'Would you like to install C\# dependencies? [Y/n]:' c_ans 

# c# stuff
if [ $c_ans == 'y' ]
then
  mkdir "$HOME/coding/c#"
  apt install -y apt-transport-https software-properties-common
  curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
  apt update
  apt install -y dotnet-sdk-7.0
  apt install -y dotnet-runtime-7.0
fi

# making directories
mkdir -p "$HOME/coding/{python,notes,dotfiles}"

# zsh setup
apt install -y zsh git tldr btop tree curl 2>/dev/null
chsh -s $(which zsh)

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# python
apt install -y python3 python3-venv python3-pip
python3 -m venv $HOME/.venv/nvim

# nvim
add-apt-repository ppa:neovim-ppa/stable
apt update
apt install neovim

# nvchad
git clone https://github.com/NvChad/starter $HOME/.config/nvim 

# moving my configs
git clone https://github.com/ikqxzi/dotfiles $HOME/
mv $HOME/dotfiles/.zshrc $HOME/.zshrc 
mv $HOME/dotfiles/.zsh_bindkey $HOME/.zsh_bindkey
mv $HOME/dotfiles/init.lua $HOME/.config/nvim/init.lua
mv $HOME/dotfiles/pyrun.sh $HOME/coding/pyrun.sh
mv $HOME/dotfiles/dotnetrun.sh $HOME/coding/dotnetrun.sh
mv $HOME/dotfiles/cheatsheet.txt $HOME/coding/notes/cheatsheet.txt
mv $HOME/dotfiles/todo.txt $HOME/coding/notes/todo.txt
touch $HOME/.transparency_state && echo "opaque" >> $HOME/.transparency_state
rm -r $HOME/dotfiles

# nvchad plugins
file="$HOME/.config/nvim/lua/custom/plugins.lua"

# Check if plugin file exists 
if [ ! -f "$file" ]; then
  echo "File does not exist. Creating the file..."
  mkdir -p "$(dirname "$file")"  
  touch "$file"  
  echo "File created successfully at $file."
else
  echo "File already exists at $file."
fi

# undotree plugin
echo "local plugins = {} \n table.insert(plugins, { 'mbbill/undotree', lazy = false }) \n return plugins" > $HOME/.config/nvim/lua/custom/plugins.lua

# sourcing both at end for safety
source $HOME/.zshrc
nvim --headless -c "luafile $HOME/.config/nvim/init.lua" -c "qa"


