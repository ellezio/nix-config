{ catppuccin-alacritty
, config
, lib
, pkgs
, ...
}:
# let
#   cfg = config.alacritty;
# in
{
  # options.alacritty = {
  #   font-size = lib.mkOption {
  #     default = null;
  #   };
  # };

  # home.packages = [ pkgs.alacritty ];

  # home.file = {
  #   ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/alacritty";
  # };

  # config.programs = {
  #   alacritty = {
  #     enable = true;
  #
  #     settings = {
  #       font = {
  #         normal = {
  #           family = "FiraMono Nerd Font";
  #           style = "Regular";
  #         };
  #       };
  #     } // builtins.fromTOML (builtins.readFile "${catppuccin-alacritty}/catppuccin-mocha.toml");
  #   };
  # };
}
