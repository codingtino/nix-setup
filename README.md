# nix-setup

## How to use

### the actual user needs to an administrator

```
bash <(curl -L s.codingtino.com/nix-setup)
```

## what it does

1. installs Xcode
2. installs Nix-Package-Manager
3. clones this Repository to ~/.config/nix
4. installs nix-darwin using the ~/.config/nix/flake.nix

## what to do after the setup

## allow Terminal full disk access

```
open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
```

## install xcode

```
while ! xcode-select -p &>/dev/null; do
    xcode-select --install &>/dev/null
    echo "Waiting for Xcode installation to complete..."
    sleep 10
done
```

```
# Check if Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
    echo "Installing Command Line Tools..."
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    CLT=$(softwareupdate -l |
        grep -E '^\s*\*' |
        grep "Command Line Tools" |
        awk -F"Label: " '/Label: /{print $2}' |
        head -n 1 |
        tr -d '\n')
    softwareupdate -i "$CLT" --verbose
    xcode-select --switch /Library/Developer/CommandLineTools
    echo "Command Line Tools installed."
else
    echo "Command Line Tools already installed."
fi
```

## install rosetta

```
/usr/sbin/softwareupdate --install-rosetta --agree-to-license || true
```

## install nix

```
sh <(curl -L https://nixos.org/nix/install) --yes
```

## enable nix in current shell

```
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

## run git via nix to download nix-setup

```
nix run --extra-experimental-features 'nix-command flakes' nixpkgs#git clone https://github.com/codingtino/nix-setup.git ~/.config/nix
```

## build nix

```
#nix build --extra-experimental-features 'nix-command flakes' ~/.config/nix#darwinConfigurations.$(hostname -s).system
nix build --extra-experimental-features 'nix-command flakes' ~/.config/nix#darwinConfigurations.ggeg-test.system
```

## switch nix

```
sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/.config/nix#ggeg-test
```

## build & switch nix

```
sudo --preserve-env=HOME nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.config/nix#ggeg-test
```
