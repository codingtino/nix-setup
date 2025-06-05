{ inputs, pkgs, unstablePkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    nixpkgs-unstable.legacyPackages.${pkgs.system}.beszel
    nixpkgs-unstable.legacyPackages.${pkgs.system}.talosctl

    ## stable
    btop
    coreutils
    diffr # Modern Unix `diff`
    difftastic # Modern Unix `diff`
    drill
    du-dust # Modern Unix `du`
    dua # Modern Unix `du`
    duf # Modern Unix `df`
    entr # Modern Unix `watch`
    fastfetch
    fd
    figurine
    gh
    git-crypt
    gnused
    hugo
    iperf3
    ipmitool
    jetbrains-mono # font
    kubectl
    mc
    mosh
    nmap
    qemu
    ripgrep
    smartmontools
    tree
    unzip
    watch
    wget
    wireguard-tools

    # requires nixpkgs.config.allowUnfree = true;
    vscode-extensions.ms-vscode-remote.remote-ssh
  ];
}
