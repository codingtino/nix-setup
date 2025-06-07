{
  inputs,
  pkgs,
  unstablePkgs,
  ...
}:
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
    nixfmt-rfc-style
    nodePackages.prettier
    qemu
    shfmt
    tmux
    tree
    unzip
    watch
    wget
#    vscode
#    vscode-extensions.bbenoist.nix
#    vscode-extensions.brettm12345.nixfmt-vscode
#    vscode-extensions.editorconfig.editorconfig
#    vscode-extensions.esbenp.prettier-vscode
#    vscode-extensions.mechatroner.rainbow-csv
#    vscode-extensions.ms-azuretools.vscode-docker
#    vscode-extensions.ms-vscode-remote.remote-ssh
#    (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
#      mktplcRef = {
#        name = "chatgpt";
#        publisher = "openai";
#        version = "0.1.1741291060";
#        sha256 = "N5MJKY0DTLCLHPaVB/k6o1j8ev7Z4VNOfYC6NU9g9RE=";
#      };
#    })
    # requires nixpkgs.config.allowUnfree = true;
    #    vscode-extensions.ms-vscode-remote.remote-ssh
  ];
}
