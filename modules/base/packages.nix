{ pkgs, upkgs, ... }: {
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
    upkgs.neovim
    starship
    bruno

    man-pages
    man-pages-posix

    libnotify
  ];

  services.dunst = {
    enable = true;
  };

  documentation.dev.enable = true;
}
