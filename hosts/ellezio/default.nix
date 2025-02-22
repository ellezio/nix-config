{ nixosSystem, ... }:
let
  hostName = "ellezio";

  system-config = { config, pkgs, ... }: {
    # Bootloader.
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };

    networking = {
      inherit hostName;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      firewall.enable = true;

      # Enable networking
      networkmanager.enable = true;

      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    services = {
      # xserver.dpi = 96;
      xserver.videoDrivers = [ "nvidia" ];

      # Enable touchpad support (enabled default in most desktopManager).
      xserver.libinput.enable = true;
    };

    hardware = {
      graphics.enable = true;
      nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidia.nvidiaSettings = true;
      nvidia.modesetting.enable = true;
    };

    system.stateVersion = "24.11";
  };

  base-modules = {
    nixos = [
      ./hardware-configuration.nix
      ../../modules/base
      ../../modules/desktop.nix
      system-config
    ];

    home = [
      ../../home
      ./home.nix
    ];
  };

  i3-module = {
    nixos = [
      { modules.desktop.xorg.enable = true; }
    ] ++ base-modules.nixos;

    home = [
      {
        modules.desktop.i3 = {
          enable = true;
          modifier = "Mod4";
        };
      }
    ] ++ base-modules.home;
  };
in
{
  nixosConfigurations.${hostName} = nixosSystem i3-module;
}
