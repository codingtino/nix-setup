{ inputs, pkgs, unstablePkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    nixpkgs-unstable.legacyPackages.${pkgs.system}.beszel

    ## stable
    btop
    cmatrix
    fastfetch
    fzf
    git
    hugo
    kubectl
    mkalias
    neovim
    qemu
    tmux
    tree
    unzip
    watch
    wget

    # requires nixpkgs.config.allowUnfree = true;
    vscode-extensions.ms-vscode-remote.remote-ssh
  ];
}
