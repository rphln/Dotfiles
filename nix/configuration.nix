{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  hardware = {
    enableAllFirmware = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Yamato";

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "America/Sao_Paulo";

  users.users.rphln = {
    description = "Raphael Nepomuceno";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "audio"
      "docker"
      "input"
      "lp"
      "networkmanager"
      "plugdev"
      "scanner"
      "video"
      "wheel"
    ];
  };

  environment.systemPackages = with pkgs; [
    alacritty
    autojump
    vscode
    stow
    git
    moreutils
    gnumake
    vim
    fish

    mpv
    btfs
    youtube-dl

    trash-cli
    mesa
    nixpkgs-fmt

    # Browser
    firefox
    plasma-browser-integration

    # Misc
    spotify
    discord
  ];

  fonts = {
    fonts = with pkgs; [
      iosevka
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    fontconfig = {
      subpixel.rgba = "none";
      defaultFonts.monospace = [ "Iosevka" ];
    };
  };

  xdg = {
    portal = {
      enable = true;
      gtkUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Section: Services

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  services.openssh = {
    enable = true;
    forwardX11 = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
  };

  system.stateVersion = "21.05";
}
