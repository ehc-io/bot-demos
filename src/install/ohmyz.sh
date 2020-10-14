#!/usr/bin/env bash
set -e
echo 'Installing zsh'
sudo apt-get -y install zsh powerline fonts-powerline
touch ~/.zshrc
echo 'Installing ohmyzsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' $HOME/.zshrc
chsh -s /bin/zsh
# plugins
echo 'Cloning some plugins'
mkdir ~/tmp ; cd ~/tmp
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
sudo apt-get install autojump
echo 'Installing fonts'
echo '################################################################'
mkdir ~/.fonts && cd ~/.fonts && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraMono.zip && \
unzip ./FiraMono.zip && rm ./FiraMono.zip && cd ~/tmp
echo 'Installing Powerline9K'
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
cd ../ & rm -fr ~/tmp