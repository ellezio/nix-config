{ nixosSystem, ... }:
let
  hostName = "ellezio";

  system-config = { config, pkgs, ... }: {
    # Bootloader.
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        configurationLimit = 10;
        efiSupport = true;
      };
    };

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      SDL
      SDL2
      SDL2_image
      SDL2_mixer
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    networking = {
      inherit hostName;

      # Open ports in the firewall.
      # firewall.allowedTCPPorts = [ ... ];
      # firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      firewall.enable = true;

      # Enable networking
      networkmanager.enable = true;

      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    powerManagement.enable = true;

    services = {
      xserver.dpi = 96;
      xserver.videoDrivers = [ "nvidia" ];

      thermald.enable = true;
      tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 50;

          TLP_DEFAULT_MODE = "BAT";
          TLP_PERSISTENT_DEFAULT = 1;

          START_CHARGE_THRESH_BAT0 = 40;
          STOP_CHARGE_THRESH_BAT0 = 60;
        };
      };

      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };

      blueman.enable = true;
    };

    boot.initrd.kernelModules = [ "nvidia" ];
    boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    hardware = {
      enableRedistributableFirmware = true;

      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Disable = "Headset";
            MultiProfile = "multiple";
          };
        };
      };

      graphics.enable = true;
      nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidia.nvidiaSettings = true;
      nvidia.modesetting.enable = true;
      nvidia.open = true;
      nvidia.prime = {
        offload.enable = true;
        offload.enableOffloadCmd = true;

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
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
