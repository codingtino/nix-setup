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
      executable = false;
  };
  home.file."Library/Application Support/test123/asd.txt" = {
      text = '''';
  };


#  home.file."/Users/t.naumann/Library/Application Support/Code/User/globalStorage/storage.json" = {
#    enable = true;
#    source = "/Users/t.naumann/Library/Application Support/Code/User/globalStorage";
#    recursive = true;
#  };

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

#  home.activation.unpackTestApp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
#    APP_DIR="$HOME/Applications"
#    WEB_APPS=(
#      "test-google,https://google.com"
#      "next-test,https://bing.com"
#    )
#    mkdir -p "$APP_DIR"
#    for entry in "''${WEB_APPS[@]}"; do
#      APP_NAME="''${entry%%,*}"
#      APP_URL="''${entry#*,}"
#      APP_PATH="$APP_DIR/$APP_NAME.app"

#      if [ ! -d "$APP_PATH" ]; then
#        nix shell nixpkgs#nodejs --command sh -c '
#          export "PATH=/usr/bin:$PATH"
#          npx --yes nativefier --no-progress --name "'"$APP_NAME"'" "'"$APP_URL"'"  >/dev/null 2>&1
#          mv "'"$HOME/''\${APP_NAME}-darwin-arm64/$APP_NAME.app"'" "'"$APP_DIR/"'"
#          rm -rf "'"$HOME/''\${APP_NAME}-darwin-arm64/"'"'
#          echo "✅ $APP_NAME.app installed."
#      else
#        echo "✅ $APP_NAME.app already exists."
#      fi
#    done
#  '';

  home.file.".hammerspoon/init.lua".text = ''
     -- Define the Hyper key combination
    local hyper = {"ctrl", "alt", "cmd", "shift"}

    -- Open Kitty academicFive with Hyper + A
    hs.hotkey.bind(hyper, "A", function()
        hs.application.launchOrFocus("academyFIVE")
    end)

    -- Open bambuStudio with Hyper + B
    hs.hotkey.bind(hyper, "B", function()
        hs.application.launchOrFocus("bambuStudio")
    end)

    -- Open Cynapp with Hyper + C
    hs.hotkey.bind(hyper, "C", function()
        hs.application.launchOrFocus("Cynapp")
    end)

    -- Open Kitty Edge with Hyper + E
    hs.hotkey.bind(hyper, "E", function()
        hs.application.launchOrFocus("Microsoft Edge")
    end)

    -- Open Finder with Hyper + F
    hs.hotkey.bind(hyper, "F", function()
        hs.application.launchOrFocus("Finder")
    end)

    -- Open Ghostty with Hyper + G
    hs.hotkey.bind(hyper, "G", function()
        hs.application.launchOrFocus("Ghostty")
    end)

    -- Open Intune with Hyper + I
    hs.hotkey.bind(hyper, "I", function()
        hs.application.launchOrFocus("Intune")
    end)

    -- Open Safari with Hyper + K
    hs.hotkey.bind(hyper, "K", function()
        hs.application.launchOrFocus("ChatGPT")
    end)

    -- Open Microsoft Outlook with Hyper + M
    hs.hotkey.bind(hyper, "M", function()
        hs.application.launchOrFocus("Microsoft Outlook")
    end)

    -- Open osTicket with Hyper + O
    hs.hotkey.bind(hyper, "O", function()
        hs.application.launchOrFocus("osTicket")
    end)

    -- Open pascom with Hyper + P
    hs.hotkey.bind(hyper, "P", function()
        hs.application.launchOrFocus("pascom Client")
    end)

    -- Open Safari with Hyper + S
    hs.hotkey.bind(hyper, "S", function()
        hs.application.launchOrFocus("Safari")
    end)

    -- Open Microsoft Teams with Hyper + T
    hs.hotkey.bind(hyper, "T", function()
        hs.application.launchOrFocus("Microsoft Teams")
    end)

    -- Open VSCode with Hyper + V
    hs.hotkey.bind(hyper, "V", function()
        hs.application.launchOrFocus("Visual Studio Code")
    end)

    -- Open Fernwartung with Hyper + W
    hs.hotkey.bind(hyper, "W", function()
        hs.application.launchOrFocus("Fernwartung")
    end)

    -- Open ChatGPT with Hyper + X
    hs.hotkey.bind(hyper, "X", function()
        hs.application.launchOrFocus("ChatGPT")
    end)

    -- Open Youtube with Hyper + Y
    hs.hotkey.bind(hyper, "Y", function()
        hs.application.launchOrFocus("YouTube")
    end)

    -- Notify when the config is loaded
    -- hs.alert.show("Hammerspoon Config Loaded")
  '';

  #  home.activation.unpackTestApp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #    mkdir -p "$HOME/Applications"
  #    ${pkgs.unzip}/bin/unzip -o "$HOME/Applications/testapp.app.zip" -d "$HOME/Applications"
  #    rm "$HOME/Applications/testapp.app.zip"
  #  '';

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

#  programs.zoxide.enable = true;
}
