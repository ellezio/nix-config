{ pkgs, ... }: {
  # Guide for configuring YubiKey as smart card
  # https://drduh.github.io/YubiKey-Guide/

  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubioath-flutter
  ];

  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
}
