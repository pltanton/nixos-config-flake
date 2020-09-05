{ options, config, pkgs, lib, inputs, ... }:

let
  secrets = import ./secrets.nix;
  pkgsStable = import <nixos-stable> { };
in rec {
  imports = (builtins.filter (builtins.pathExists) [
    ./hardware-configuration.nix
    ./systemPackages.nix
    ./wg.nix
  ]);

  nixpkgs.overlays = [ (import ./overlays) (import ../../overlays/customPackages.nix) ];

  home-manager.users.anton = import ../../home/anton/home.nix;

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  nixpkgs.config.allowBroken = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = { canTouchEfiVariables = true; };
    };

    plymouth.enable = true;
  };

  gtk.iconCache.enable = true;

  networking = {
    #nameservers = [ "8.8.8.8" ];
    hostName = "nixos";
    hosts = { };
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 22 8888 ];
    firewall.enable = false;
  };

  console.font = "Lat2-Terminus16";
  console.keyMap = "dvorak";
  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Europe/Moscow";

  nixpkgs.config.allowUnfree = true;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [ dejavu_fonts terminus_font ];
  };

  hardware = {
    enableRedistributableFirmware = true;

    bluetooth = {
      config = {
        "General" = {
          "AutoConnect" = true;
          "Enable" = "Source,Sink,Media,Control,Gateway,Socket,Headset";
          "MultiProfile" = "multiple";
        };
      };
    };
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.support32Bit = true;
    pulseaudio.extraConfig = ''
      load-module module-alsa-sink device=hw:0,7
      load-module module-bluetooth-policy auto_switch=2
    '';
    pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

    pulseaudio.tcp.anonymousClients.allowedIpRanges =
      [ "127.0.0.1" "192.168.0.0/16" ];
    pulseaudio.tcp.enable = true;
    pulseaudio.zeroconf.publish.enable = true;

    bluetooth.enable = true;

    opengl.driSupport32Bit = true;
    opengl.enable = true;
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

    steam-hardware.enable = true;

    trackpoint = {
      enable = true;
      emulateWheel = true;
    };

    sane.enable = true;
    #sane.snapshot = true;
    sane.netConf = "192.168.20.3";
  };

  nixpkgs.config.pulseaudio = true;

  virtualisation = {
    docker.enable = true;

    podman = {
      enable = false;
      dockerCompat = true;
    };

    #virtualbox.host.enable = true;
    #virtualbox.host.enableExtensionPack = true;
  };

  services = import ./modules/services pkgs;

  programs.zsh.enable = true;
  programs.adb.enable = true;

  users = {
    users = {
      anton = {
        isNormalUser = true;
        shell = pkgs.zsh;
        home = "/home/anton";
        extraGroups = [
          "adbusers"
          "wheel"
          "networkmanager"
          "audio"
          "docker"
          "lp"
          "scanner"
          "vboxusers"
        ];
      };

      julsa = {
        isNormalUser = true;
        shell = pkgs.zsh;
        home = "/home/julsa";
        extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
      };
    };
  };

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
    stateVersion = "unstable";
  };
}
