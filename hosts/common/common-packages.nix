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
    nodePackages.prettier
    qemu
    tmux
    tree
    unzip
    watch
    wget
          (vscode-with-extensions.override {
            vscodeExtensions = builtins.concatLists [
              (with pkgs.vscode-extensions; [
                esbenp.prettier-vscode
                ms-azuretools.vscode-docker
                mechatroner.rainbow-csv
                ms-vscode-remote.remote-ssh
              ])
              (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                  name = "remote-ssh-edit";
                  publisher = "ms-vscode-remote";
                  version = "0.47.2";
                  sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
                }
                {
                  name = "chatgpt";
                  publisher = "openai";
                  version = "0.1.1741291060";
                  sha256 = "N5MJKY0DTLCLHPaVB/k6o1j8ev7Z4VNOfYC6NU9g9RE=";
                }
              ])
            ];
          })

    # requires nixpkgs.config.allowUnfree = true;
#    vscode-extensions.ms-vscode-remote.remote-ssh
  ];
}
