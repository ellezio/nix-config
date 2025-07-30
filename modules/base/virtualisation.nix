{ pkgs, username, ... }: {
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker;
  };

  users.users.${username} = {
    extraGroups = [ "docker" ];
  };
}
