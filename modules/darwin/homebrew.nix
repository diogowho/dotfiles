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
      "uBlock Origin Lite" = 6745342698;
      "SponsorBlock" = 1573461917;
      "Kagi" = 1622835804;
      "Userscripts" = 1463298887;
    };

    brews = [
      "mas"
      "bitwarden-cli"
    ];

    casks = [
      "aldente"
      "font-maple-mono"
      "sketch@beta"
      "signal"
    ]
    ++ lib.optionals config.sys.profiles.gaming.enable [
      "steam"
      "prismlauncher"
      "crossover"
    ];
  };
}
