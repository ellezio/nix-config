{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    btop
    pciutils
    usbutils
    # toybox
    git
    tmux
    neovim
    starship
    bruno

    man-pages
    man-pages-posix
  ];

  documentation.dev.enable = true;
}
