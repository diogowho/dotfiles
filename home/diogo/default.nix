{ lib, pkgs, ... }:
{
  home.file.".hushlogin".text = "";

  imports = [
    # keep-sorted start
    ./cli
    ./gui
    ./packages.nix
    ./system
    ./themes
    ./tui
    # keep-sorted end
  ];

  targets.darwin = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    copyApps = {
      enable = true;
      enableChecks = true;
    };

    linkApps.enable = false;
  };
}
