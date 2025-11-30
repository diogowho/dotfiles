{ pkgs, ... }:
{
  system.defaults = {
    dock = {
      autohide = true;
      tilesize = 35;
      orientation = "left";
      show-recents = false;
      minimize-to-application = true;
      mru-spaces = false;
      persistent-apps = [
        { app = "/Applications/Orion.app"; }
        { app = "/System/Applications/Mail.app"; }
        { app = "${pkgs.ghostty-bin}/Applications/Ghostty.app"; }
        { app = "${pkgs.vesktop}/Applications/Vesktop.app"; }
        { app = "/System/Applications/System Settings.app"; }
      ];
    };

    CustomUserPreferences."com.apple.dock".size-immutable = true;
  };
}
