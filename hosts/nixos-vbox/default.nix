{ nixosSystem, ... }:
let
  hostName = "nixos-vbox";

  base-config = { pkgs, ... }: {
    # Bootloader.
    boot.loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };

    networking = {
      inherit hostName;
      firewall.enable = false;

      # Enable networking
      networkmanager.enable = true;

      # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    # hardware = {
    #   graphics.enable = true;
    #   graphics.enable32Bit = true;
    #   graphics.extraPackages = with pkgs; [
    #     mesa
    #     mesa.drivers
    #   ];
    # };

    virtualisation.virtualbox.guest.enable = true;
    services.xserver.videoDrivers = [ "wmware" ];

    system.stateVersion = "24.11";
  };

  base-modules = {
    nixos = [
      ./hardware-configuration.nix
      ../../modules/base
      ../../modules/desktop.nix
      base-config
    ];

    home = [
      ../../home
      ./home.nix
    ];
  };

  i3-modules = {
    nixos = [
      { modules.desktop.xorg.enable = true; }
    ] ++ base-modules.nixos;

    home = [
      {
        modules.desktop.i3 = {
          enable = true;
          modifier = "Mod1";
        };
      }
    ] ++ base-modules.home;
  };
in
{
  nixosConfigurations.${hostName} = nixosSystem i3-modules;
}
