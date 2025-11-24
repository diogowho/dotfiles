{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    inherit (config.sys.profiles.graphical) enable;

    policies = {
      AppAutoUpdate = false;
      DisableAppUpdate = true;
      ManualAppUpdateOnly = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
      NoDefaultBookmarks = true;
      Cookies = {
        Allow = [
          "https://bsky.app"
          "https://tangled.org"
          "https://github.com"
          "https://steamcommunity.com"
          "https://steampowered.com"
          "https://google.com"
          "https://youtube.com"
          "https://bunny.net"
          "https://twitch.tv"
          "https://apple.com"
          "https://icloud.com"
          "https://instagram.com"
          "https://porkbun.com"
          "https://amazon.es"
          "https://upcloud.com"
          "https://chatgpt.com"
          "https://openai.com"
          "https://revolut.com"
          "https://proton.me"
          "https://bitwarden.com"
          "https://bitwarden.eu"
          "https://catsky.social"
          "https://gandi.net"
          "https://stripe.com"
          "https://pdsls.dev"
          "http://100.100.10.2"
        ];
      };
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        FormData = true;
      };
      DisableFirefoxAccounts = true;
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://dns.quad9.net/dns-query";
        Fallback = true;
        Locked = true;
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      HttpsOnlyMode = "force_enabled";
      SkipTermsOfUse = true;
      Extensions = {
        Install = [
          "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-web-file-icons/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/steam-database/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/web-scrobbler/latest.xpi"
        ];
      };
      SearchEngines = {
        Add = [
          {
            Name = "Qwant";
            IconURL = "https://www.qwant.com/favicon.ico";
            URLTemplate = "https://www.qwant.com/?q={searchTerms}";
            Alias = "qwant";
            SuggestURLTemplate = "https://api.qwant.com/api/suggest/?q={searchTerms}";
          }
        ];
        Default = "Qwant";
      };
    };

    profiles.default = rec {
      settings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.welcome-screen.seen" = true;
        "zen.tabs.vertical.right-side" = true;
        "zen.urlbar.behavior" = "float";
        "zen.view.sidebar-expanded" = false;
        "zen.view.use-single-toolbar" = false;
      };

      pinsForce = true;
      pins = {
        "YouTube" = {
          id = "c1e24192-acf6-4454-a4e0-b57483e6fd49";
          workspace = spaces."Personal".id;
          url = "https://youtube.com";
          position = 101;
          isEssential = true;
        };
        "Bluesky" = {
          id = "f58aa4ce-5915-41c8-b117-b11c32531198";
          workspace = spaces."Personal".id;
          url = "https://catsky.social";
          position = 102;
          isEssential = true;
        };
        "Tangled" = {
          id = "c1d9c4f8-ec95-4f41-93fd-76a92f5fdf16";
          workspace = spaces."Personal".id;
          url = "https://tangled.org";
          position = 103;
          isEssential = true;
        };

        "GitHub" = {
          id = "b3bf5dfd-f08b-4407-a9c3-8ce40eb53e74";
          workspace = spaces."Personal".id;
          url = "https://github.com";
          position = 104;
          isEssential = false;
        };
        "Codeberg" = {
          id = "34db494e-0238-44b0-8836-b1cdfa82e677";
          workspace = spaces."Personal".id;
          url = "https://codeberg.org";
          position = 105;
          isEssential = false;
        };
        "Bunny" = {
          id = "e82607e2-2f86-4d9a-9168-65d4cd766f5e";
          workspace = spaces."Personal".id;
          url = "https://dash.bunny.net";
          position = 106;
          isEssential = false;
        };
        "Porkbun" = {
          id = "66a2c410-915f-4bb2-91a8-4fc83633382b";
          workspace = spaces."Personal".id;
          url = "https://porkbun.com/account/domainsSpeedy";
          position = 107;
          isEssential = false;
        };
        "UpCloud" = {
          id = "95ee2678-e60d-4f2b-9b8b-4da2f246b197";
          workspace = spaces."Personal".id;
          url = "https://hub.upcloud.com";
          position = 108;
          isEssential = false;
        };
        "Gandi" = {
          id = "53418beb-79a3-41d5-b0ba-75d3a48188b5";
          workspace = spaces."Personal".id;
          url = "https://admin.gandi.net";
          position = 109;
          isEssential = false;
        };
      };

      containersForce = true;
      containers = {
        Shopping = {
          color = "yellow";
          icon = "dollar";
          id = 2;
        };
      };

      spacesForce = true;
      spaces = {
        "Personal" = {
          id = "8abbe7cb-3f97-446f-b986-f2f598cd0bdc";
          icon = "🌷";
          position = 1000;
          theme = {
            type = "gradient";
            colors = [
              {
                red = 216;
                green = 204;
                blue = 235;
                algorithm = "floating";
                type = "explicit-lightness";
              }
            ];
            opacity = 0.8;
            texture = 0.5;
          };
        };
      };
    };
  };
}
