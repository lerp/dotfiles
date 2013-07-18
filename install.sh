# Set up a symbolic link to the vimrc file
mkdir -p ~/.vim

echo "Linking vimrc..."
ln -s ~/dotfiles/vimrc ~/.vim/.vimrc

# Install vundle
echo "Installing vundle"
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone git://github.com/gmarik/vundle

#Install jellybeans
echo "Installing jellybeans"
mkdir -p ~/.vim/colors
cd ~/.vim/colors
wget https://raw.github.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim 


