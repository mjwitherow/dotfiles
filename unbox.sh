# Requires Git

# Homebrew
echo | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# ZSH
echo | sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
\cp configs/.zshrc ~/
# Set as default shell
chsh -s $(which zsh)

# Vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
\cp configs/.vimrc ~/ &&
vim +PluginInstall +qall

# TMUX
brew install tmux

# MTR (networks)
brew install mtr

# Javascript and friends
brew install npm
