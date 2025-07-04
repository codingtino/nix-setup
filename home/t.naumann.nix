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

  home.file."Library/Application Support/Code/User/globalStorage/storage.json" = {
    text = '''';
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
        "git.autofetch" = true;
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

  programs.git = {
    enable = true;
    userEmail = "172442418+codingtino@users.noreply.github.com";
    userName = "Tino Naumann";
  };

  programs.home-manager.enable = true;
  programs.nix-index.enable = true;

  programs.bat.enable = true;
  programs.bat.config.theme = "Visual Studio Dark+";
  programs.zsh.shellAliases.cat = "${pkgs.bat}/bin/bat";


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";
      custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
      plugins = [ "git" "z" "zsh-autosuggestions" "zsh-syntax-highlighting" ];
    };
  };

  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];

  home.file.".p10k.zsh".source = ./.p10k.zsh;
  home.file.".zshrc".source = ./.zshrc;

  home.activation.unpackTestApp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    APP_DIR="$HOME/Applications"
      WEB_APPS=(
        "academyFIVE,http://ac5-prod.macromedia.de/"
        "Cynap,https://cynapmgmt.mmlogin.org/"
        "Fernwartung,https://remote.gge-germany.de/"
        "Intune,https://intune.microsoft.com/"
        "osTicket,https://support.gge-germany.de/scp/"
        "YouTube,https://youtube.com/"
      )
      mkdir -p "$APP_DIR"
      for entry in "''${WEB_APPS[@]}"; do
        APP_NAME="''${entry%%,*}"
        APP_URL="''${entry#*,}"
        APP_PATH="$APP_DIR/$APP_NAME.app"

        if [ ! -d "$APP_PATH" ]; then
          nix shell nixpkgs#nodejs --command sh -c '
            export "PATH=/usr/bin:$PATH"
            npx --yes nativefier --no-progress --name "'"$APP_NAME"'" "'"$APP_URL"'"  >/dev/null 2>&1
            mv "'"$HOME/''\${APP_NAME}-darwin-arm64/$APP_NAME.app"'" "'"$APP_DIR/"'"
            rm -rf "'"$HOME/''\${APP_NAME}-darwin-arm64/"'"'
            echo "✅ $APP_NAME.app installed."
        else
          echo "✅ $APP_NAME.app already exists."
        fi
      done
    '';

  home.file.".hammerspoon/init.lua".source = ./hammerspoon.lua;


#  home.file.".hammerspoon/init.lua".text = ''
#'';


  # programs.neovim = {
  #   enable = true;
  #   viAlias = true;
  #   vimAlias = true;
  #   vimdiffAlias = true;
  #   plugins = with pkgs.vimPlugins; [
  #     ## regular
  #     comment-nvim
  #     lualine-nvim
  #     nvim-web-devicons
  #     vim-tmux-navigator

  #     ## with config
  #     # {
  #     #   plugin = gruvbox-nvim;
  #     #   config = "colorscheme gruvbox";
  #     # }

  #     {
  #       plugin = catppuccin-nvim;
  #       config = "colorscheme catppuccin";
  #     }

  #     ## telescope
  #     {
  #       plugin = telescope-nvim;
  #       type = "lua";
  #       config = builtins.readFile ./nvim/plugins/telescope.lua;
  #     }
  #     telescope-fzf-native-nvim

  #   ];
  #   extraLuaConfig = ''
  #     ${builtins.readFile ./nvim/options.lua}
  #     ${builtins.readFile ./nvim/keymap.lua}
  #   '';
  #  };

  programs.zoxide.enable = true;
}
