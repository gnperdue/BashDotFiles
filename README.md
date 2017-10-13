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

For ssh access, instead of authentication tokens, use rsa keygen.

## Kerberos

The Ticket Viewer App is in /System/Library/CoreServies on OSX.

Get `krb5.conf` from metrics.fnal.gov/authentication/krb5conf/OSX/krb5.conf,
copy to `/etc/krb5.conf`.

Next, edit `/etc/ssh/ssh_config` and add
  
    GSSAPIAuthentication yes
    GSSAPIDelegateCredentials yes
    ForwardX11Trusted yes
    ForwardX11 yes

## Shell

* Download and install iTerm2. Set up preferences loading. (Start with the
saved plist file here.)
* Check `BashDotFiles` (GitHub if needed) and check the installler scripts.
* Install XCode with support tools
* Get Homebrew from https://brew.sh & install needed packages.
* Set up Lisp stuff for emacs
* Get `EmacsConfiguration` (GitHub if needed) and install.
* Get `VimConfiguration` (GitHub if needed) and install.

## Git

* Copy `gitconfig` to `~/.gitconfig` and edit.
* Run `git config --global credential.helper osxkeychain`
* Check https://help.github.com/articles/caching-your-github-password-in-git/
* Create a new access token and add it to `~/.gitconfig`

## Misc

Get XQuartz at www.quartz.org
