# nix-setup


sh <(curl -L https://nixos.org/nix/install) --yes
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

nix run --extra-experimental-features nix-command --extra-experimental-features flakes nixpkgs#git clone https://github.com/codingtino/nix-setup.git ~/.config
nix build --extra-experimental-features 'nix-command flakes' .#darwinConfigurations.$(hostname -s).system
