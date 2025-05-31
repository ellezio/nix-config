{ upkgs, username, ... }: {
  virtualisation.docker = {
    enable = true;
    package = upkgs.docker;
  };

  users.users.${username} = {
    extraGroups = [ "docker" ];
  };
}
