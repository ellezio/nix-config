{ pkgs, upkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    neofetch
    btop
    pciutils
    usbutils
    toybox
  ] ++ (with upkgs; [
    git
    tmux
    neovim
  ]);
}
