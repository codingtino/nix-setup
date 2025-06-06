{
  config,
  inputs,
  pkgs,
  lib,
  unstablePkgs,
  ...
}:
{
  home.stateVersion = "25.05";

  programs.gpg.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          bbenoist.nix
          brettm12345.nixfmt-vscode
          editorconfig.editorconfig
          esbenp.prettier-vscode
          mechatroner.rainbow-csv
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-ssh
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "chatgpt";
            publisher = "openai";
            version = "0.1.1741291060"; # Use the latest version you want
            sha256 = "N5MJKY0DTLCLHPaVB/k6o1j8ev7Z4VNOfYC6NU9g9RE="; # Replace if version changes
          }
        ];

      userSettings = {
        "shfmt.binaryPath" = "${pkgs.shfmt}/bin/shfmt";
        "editor.formatOnSave" = true;
        "editor.tabSize" = 2;
        "editor.tabCompletion" = "on";
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "nix.formatterPath" = "${pkgs.nixfmt}/bin/nixfmt";
        "prettier.prettierPath" =
          "${pkgs.vscode-extensions.esbenp.prettier-vscode}/share/vscode/extensions/esbenp.prettier-vscode/node_modules/prettier";
        "[shellscript]" = {
          "editor.defaultFormatter" = "mvdan.sh";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[html]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[yaml].editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[nix]" = {
          "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
        };
      };
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
      "--color=auto"
    ];
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
    defaultOptions = [ "--no-mouse" ];
  };

  programs.git = {
    enable = true;
    userEmail = "172442418+codingtino@users.noreply.github.com";
    userName = "Tino Naumann";
  };

  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  programs.lf.enable = true;

  programs.bash.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    #initExtra = (builtins.readFile ../mac-dot-zshrc);
  };

  programs.tmux = {
    enable = true;
    #keyMode = "vi";
    clock24 = true;
    historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      gruvbox
      vim-tmux-navigator
    ];
    extraConfig = ''
      new-session -s main
      bind-key -n C-a send-prefix
    '';
  };

  programs.home-manager.enable = true;
  programs.nix-index.enable = true;

  programs.alacritty.enable = true;

  programs.bat.enable = true;
  programs.bat.config.theme = "Visual Studio Dark+";
  programs.zsh.shellAliases.cat = "${pkgs.bat}/bin/bat";

#  home.file."Applications/testapp.app.zip" = {
#    source = inputs.self + "/assets/webapps/testapp.app.zip";
#  };

#  home.activation.unpackTestApp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
#    mkdir -p "$HOME/Applications"
#    ${pkgs.unzip}/bin/unzip -o "$HOME/Applications/testapp.app.zip" -d "$HOME/Applications"
#    rm "$HOME/Applications/testapp.app.zip"
#  '';

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      ## regular
      comment-nvim
      lualine-nvim
      nvim-web-devicons
      vim-tmux-navigator

      ## with config
      # {
      #   plugin = gruvbox-nvim;
      #   config = "colorscheme gruvbox";
      # }

      {
        plugin = catppuccin-nvim;
        config = "colorscheme catppuccin";
      }

      ## telescope
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/telescope.lua;
      }
      telescope-fzf-native-nvim

    ];
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
      ${builtins.readFile ./nvim/keymap.lua}
    '';
  };

  programs.zoxide.enable = true;
}
