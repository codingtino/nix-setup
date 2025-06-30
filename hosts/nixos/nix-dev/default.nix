{ config, pkgs, customArgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./../../common/common-packages.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";

  users.groups.${customArgs.username} = {};
  users.users.${customArgs.username} = {
    group = customArgs.username;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [
      firefox
    ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
#  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
#  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
#  services.xserver.xkb = {
#    layout = "de";
#    variant = "";
#  };


programs.hyprland = {
  enable = true;
#  nvidiaPatches = true;
  xwayland.enable = true;
};

services.displayManager.sddm.wayland.enable = true;
services.displayManager.sddm.enable = true;




environment.sessionVariables = {
#  If your cursor becomes invisible
#  WLR_NO_HARDWARE_CURSORS = "1";
#  Hint electron apps to use wayland
  NIXOS_OZONE_WL = "1";
};

services.xserver.videoDrivers = [ "nvidia" ];

hardware = {
#    Opengl
    graphics.enable = true;

#    Most wayland compositors need this
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      open = true;
      nvidiaSettings = true;
      prime = {
        sync.enable = false;
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
};

#XDG portal
xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];


  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tino = {
    isNormalUser = true;
    description = "Tino";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

#  nixpkgs.overlays = [
#    (final: prev: {
#      btop-gpu = prev.btop.overrideAttrs(old: {
#        configureFlags = old.configureFlags or [] ++ [ "--enable-vulkan" ];
#        buildInputs = old.buildInputs ++ [ prev.vulkan-headers ];
#      });
#    })
#  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
#    btop-gpu
    btop
    cmatrix
    dunst
    kdePackages.dolphin
    ghostty
    hypridle
    hyprlock
    intel-gpu-tools
    libnotify
    networkmanagerapplet
#    nvidia-smi
    nvtopPackages.nvidia
    swww
    waybar
    wofi
];

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        font-awesome
    ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
