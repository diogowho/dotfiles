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
          rev = "5b104d8d7a7b36f46d0b401d05b76223e4e563a0";
          hash = "sha256-ounBeVA8dzrZ/K10CIa2zRkCPjGd+nWL6kqpETFAktk=";
        };
        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "247fe8e7eac947fd72d620ba30792925af93167d";
          hash = "sha256-WnmrHLadWR1bxWpmcfziY62U5oQkNREweNqE0H5k1fw=";
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
        #   "TestFlight" = 899247664;
        #   "WhatsApp" = 310633997;
        #   "WireGuard" = 1451685025;
        #   "Bitwarden" = 1352778147;
      };

      brews = [
        "bitwarden-cli"
      ];

      casks = [
        "1password"
        "aldente"
        "font-maple-mono"
        "signal"
        "raycast"
        "sketch@beta"
        "tidal"
      ]
      ++ lib.optionals config.sys.profiles.gaming.enable [
        "steam"
        "prismlauncher"
      ];
    };
  };
}
