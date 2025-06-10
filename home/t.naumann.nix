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
  programs.zsh.initExtra = ''
    [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
  '';

  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];

  home.file.".p10k.zsh".text = ''
    'builtin' 'local' '-a' 'p10k_config_opts'
    [[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
    [[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
    [[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
    'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

    () {
      emulate -L zsh -o extended_glob

      unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

      [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

      local grey='242'

      typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      )

      typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
      )


      typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

      typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=$magenta
      typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=$red
      typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
      typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
      typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='❮'
      typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=false

      typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=$grey
      typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
      typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

      typeset -g POWERLEVEL9K_DIR_FOREGROUND=$blue

      typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE="%F{$white}%n%f%F{$grey}@%m%f"
      typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE="%F{$grey}%n@%m%f"
      typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_CONTENT_EXPANSION=

      typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5
      typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
      typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
      typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$yellow

      typeset -g POWERLEVEL9K_VCS_FOREGROUND=$grey

      typeset -g POWERLEVEL9K_VCS_LOADING_TEXT=

      typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0

      typeset -g POWERLEVEL9K_VCS_{INCOMING,OUTGOING}_CHANGESFORMAT_FOREGROUND=$cyan
      typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind)
      typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=
      typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'
      typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED}_ICON=
      typeset -g POWERLEVEL9K_VCS_DIRTY_ICON='*'
      typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=':⇣'
      typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=':⇡'
      typeset -g POWERLEVEL9K_VCS_{COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=1
      typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${${${P9K_CONTENT/⇣* :⇡/⇣⇡}// }//:/ }'

      typeset -g POWERLEVEL9K_TIME_FOREGROUND=$grey
      typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
      typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

      typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

      typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

      typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

      (( ! $+functions[p10k] )) || p10k reload
    }

    typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

    'builtin' 'unset' 'p10k_config_opts'
  '';

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


    -- Remap Hyper + Down Arrow to minimize the focused window
    hs.hotkey.bind(hyper, "down", function()
      local win = hs.window.focusedWindow()
      if win then
        win:minimize()
      end
    end)

    -- Remap Hyper + Up Arrow to maximize the focused window
    hs.hotkey.bind(hyper, "up", function()
      local win = hs.window.focusedWindow()
      if win then
        win:maximize()
      end
    end)

    -- Remap Hyper + right Arrow to Move focused window to the next screen
    hs.hotkey.bind(hyper, "right", function()
      local win = hs.window.focusedWindow()
      if win then
        local nextScreen = win:screen():next()
        win:moveToScreen(nextScreen)
      end
    end)

    -- Remap Hyper + left Arrow to Move focused window to the previous screen
    hs.hotkey.bind(hyper, "left", function()
      local win = hs.window.focusedWindow()
      if win then
        local prevScreen = win:screen():previous()
        win:moveToScreen(prevScreen)
      end
    end)

    -- Remap Hyper + Tab to switch focused between windows of same application
    hs.hotkey.bind(hyper, "tab", function()
      local win = hs.window.focusedWindow()
      if not win then return end
      
      local app = win:application()
      if not app then return end
      
      -- Get all visible windows of the current app
      local windows = hs.fnutils.filter(app:allWindows(), function(w)
        return w:isStandard() and w:isVisible()
      end)
      
      if #windows <= 1 then return end
      
      -- Sort them by window ID for consistency
      table.sort(windows, function(a, b)
        return a:id() < b:id()
      end)
      
      -- Find current window index
      local currentIndex = hs.fnutils.indexOf(windows, win)
      local nextIndex = currentIndex % #windows + 1
      
      -- Focus the next window
      windows[nextIndex]:focus()
    end)
      
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
