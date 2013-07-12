# Set up a symbolic link to the vimrc file
echo "Linking vimrc..."
ln -s ~/dotfiles/vimrc ~/.vim/vimrc

# Install vundle
echo "Installing vundle"
cd ~/.vim/bundle
git clone git://github.com/gmarik/vundle

#Install jellybeans
echo "Installing jellybeans"
cd ~/.vim/colors
wget https://raw.github.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim 


