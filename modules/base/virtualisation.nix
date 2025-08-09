{ pkgs, username, lib, ... }: {

  # distrobox SELinux - https://github.com/NixOS/nixpkgs/issues/414135
  security.lsm = lib.mkForce [ ];

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker;
  };

  users.users.${username} = {
    extraGroups = [ "docker" ];
  };
}
