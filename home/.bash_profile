export PATH=/usr/local/git/bin:$PATH
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-13.0.2.jdk/Contents/Home

if [[ -f /opt/dev/dev.sh ]]; then source /opt/dev/dev.sh; fi
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/opt/libxml2/lib/pkgconfig:/usr/local/opt/shopify-imagemagick@6/lib/pkgconfig
if [ -e /Users/patrickfang/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/patrickfang/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
else
  echo "Could not find ~/.bashrc"
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
