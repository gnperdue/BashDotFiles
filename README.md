My bash config files. The `bash_prof_local_x` files are symlinked to 
`bash_prof_local` on different machines (one desktop, one laptop, one
for Ttian (ORNL), and one for my ubuntu VMs).

Note that `gitignore_global` is linked also. `gitconfig` is not linked and
will generally require custom setup work. In particular, for OSX, you
will need to install the keychain credential helper for https token access.
On Linux, you will need to do something like:

    sudo apt-get install libgnome-keyring-dev
    sudo make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring
    git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring

