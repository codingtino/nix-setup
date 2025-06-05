# nix-setup

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
nix run --extra-experimental-features nix-command --extra-experimental-features flakes nixpkgs#git clone https://github.com/codingtino/nix-setup.git ~/.config/nix
```

## build nix
```
#nix build --extra-experimental-features 'nix-command flakes' ~/.config/nix#darwinConfigurations.$(hostname -s).system
nix build --extra-experimental-features 'nix-command flakes' ~/.config/nix#darwinConfigurations.#ggeg-test.system
```

## switch nix
```
sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/.config/nix-darwin
```

## build & switch nix
```
sudo --preserve-env=HOME nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.config/nix#ggeg-test
```

