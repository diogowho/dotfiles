{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.homebrew.darwinModules.nix-homebrew
    ./environment.nix
  ];

  config = {
    nix-homebrew = {
      enable = true;
      taps = {
        "homebrew/homebrew-core" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-core";
          rev = "55d89031f21b25678d0c754ccf8b81ba5aa0acde";
          hash = "sha256-wMd4bCvYN7UvMd+ceksCejhm729wirvYiM/CI859jmY=";
        };
        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "ef5494c34b72bfb282a59698edbce17e02df19cf";
          hash = "sha256-CeOr/Vsg1hDswYrcfj4KF+EzXBq+FmZClvigvM095zo=";
        };
      };
      mutableTaps = false;
      user = "diogo";
      autoMigrate = true;
    };

    homebrew = {
      enable = true;

      global.autoUpdate = true;

      onActivation = {
        upgrade = true;
        cleanup = "zap";
      };

      taps = builtins.attrNames config.nix-homebrew.taps;

      masApps = {
        # "TestFlight" = 899247664;
        # "WhatsApp" = 310633997;
        # "Bitwarden" = 1352778147;
      };

      brews = [
        "mas"
        "bitwarden-cli"
      ];

      casks = [
        "aldente"
        "font-maple-mono"
        "signal"
        "raycast"
        "sketch@beta"
        "tidal"
        "tailscale-app"
      ]
      ++ lib.optionals config.sys.profiles.gaming.enable [
        "steam"
        "prismlauncher"
        "crossover"
      ];
    };
  };
}
