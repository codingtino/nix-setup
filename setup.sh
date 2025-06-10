#!/bin/bash

ls ~/Library/Mail &>/dev/null
#touch /Library/Application\ Support/fakefile 2>/dev/null

open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
echo "⚠️  Please enable Full Disk Access for Terminal.app, then press Enter to continue..."
read -r
rm -rf /Library/Application\ Support/fakefile

# install Command Line Tools
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
  rm -rf /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  echo "Command Line Tools installed."
else
  echo "Command Line Tools already installed."
fi

## install rosetta
/usr/sbin/softwareupdate --install-rosetta --agree-to-license || true

## install nix
sh <(curl -L https://nixos.org/nix/install) --yes

## enable nix in current shell
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

## run git via nix to download nix-setup
git clone https://github.com/codingtino/nix-setup.git ~/.config/nix

## build nix
nix build --extra-experimental-features 'nix-command flakes' ~/.config/nix#darwinConfigurations.ggeg-test.system

## switch nix
sudo ./result/sw/bin/darwin-rebuild switch --flake ~/.config/nix#ggeg-test

open -a Shortcat
echo "opened Shortcat"
echo "Press 'y' to continue..."
while :; do
  read -n 1 -s key # Read one character silently (no echo)
  if [[ $key == "y" ]]; then
    break
  fi
done

open -a Rectangle
echo "opened Rectangle"
echo "Press 'y' to continue..."
while :; do
  read -n 1 -s key # Read one character silently (no echo)
  if [[ $key == "y" ]]; then
    break
  fi
done

open -a Hyperkey
echo "opened Hyperkey"
echo "Press 'y' to continue..."
while :; do
  read -n 1 -s key # Read one character silently (no echo)
  if [[ $key == "y" ]]; then
    break
  fi
done

open -a Hammerspoon
echo "opened Hammerspoon"
echo "Press 'y' to continue..."
while :; do
  read -n 1 -s key # Read one character silently (no echo)
  if [[ $key == "y" ]]; then
    break
  fi
done
