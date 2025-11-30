{
  config,
  lib,
  ...
}:
{
  homebrew = {
    enable = true;

    global.autoUpdate = true;

    onActivation = {
      upgrade = true;
      cleanup = "zap";
    };

    taps = [ ];

    masApps = {
      "WhatsApp" = 310633997;
      "Bitwarden" = 1352778147;
      "Tailscale" = 1475387142;
    };

    brews = [
      "mas"
      "bitwarden-cli"
    ];

    casks = [
      "aldente"
      "font-maple-mono"
      "sketch@beta"
      "orion"
    ]
    ++ lib.optionals config.sys.profiles.gaming.enable [
      "steam"
      "prismlauncher"
      "crossover"
    ];
  };
}
