{ pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.variables.EDITOR = "nvim";
  environment.etc.hosts.mode = "0644";

  # Configure console keymap
  console.keyMap = "pl2";

  services.gnome.gnome-keyring.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
}
