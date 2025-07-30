{ config, lib, pkgs, ... }: with lib; let
  cfgXorg = config.modules.desktop.xorg;
in
{
  options.modules.desktop = {
    xorg.enable = mkEnableOption "Xorg display server";
  };

  config = mkIf cfgXorg.enable {
    # environment.pathsToLink = [ "/libexec" ];
    services = {
      # displayManager.defaultSession = "hm-session";
      displayManager.defaultSession = "none+i3";

      xserver = {
        enable = true;

        # displayManager = {
        #   lightdm.enable = true;
        #
        #   # session = [
        #   #   {
        #   #     name = "hm-session";
        #   #     manage = "window";
        #   #     start = ''
        #   #       ${pkgs.runtimeShell} $HOME/.xsession &
        #   #       waitPID=$!
        #   #     '';
        #   #   }
        #   # ];
        # };

        # desktopManager.xterm.enable = false;
        # desktopManager = {
        #   runXdgAutostartIfNone = true;
        #   session = [
        #     {
        #       name = "hm-session";
        #       manage = "window";
        #       start = ''
        #         ${pkgs.runtimeShell} $HOME/.xsession &
        #         waitPID=$!
        #       '';
        #     }
        #   ];
        # };

        windowManager.i3 = {
          enable = true;
          # configFile = "/home/pawellendzion/.config/i3/config";
          extraPackages = with pkgs; [
            # dmenu
            # i3status
            # i3lock
            # i3blocks

            rofi
            i3status
            xss-lock
            brightnessctl
            (polybar.override { i3Support = true; pulseSupport = true; })
          ];
        };

        xkb = {
          layout = "pl";
          variant = "";
        };
      };
    };
  };
}
