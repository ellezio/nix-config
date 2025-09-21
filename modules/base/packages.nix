{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    neofetch
    btop
    pciutils
    usbutils
    # toybox
    git
    tmux
    neovim
    starship
    bruno
  ];
}
