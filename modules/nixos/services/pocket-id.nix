{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.pocket-id;
in
{
  options.sys.services.pocket-id = mkServiceOption "pocket-id" {
    domain = "id.${config.networking.domain}";
    port = 1411;
  };

  config = mkIf cfg.enable {
    sops.secrets.pocket-id = {
      sopsFile = "${self}/secrets/services/pocket-id.yaml";
      owner = "pocket-id";
      group = "pocket-id";
    };

    services = {
      pocket-id = {
        enable = true;

        settings = {
          APP_URL = "https://${cfg.domain}";
          DB_PROVIDER = "postgres";
          FILE_BACKEND = "database"; # please don't mind me
          KEYS_STORAGE = "database";
          HOST = cfg.host;
          PORT = cfg.port;
          ANALYTICS_DISABLED = true;
          UI_CONFIG_DISABLED = true;
          EMAILS_VERIFIED = true;
          ALLOW_USER_SIGNUPS = "withToken";
        };

        environmentFile = config.sops.secrets.pocket-id.path;
      };

      caddy.virtualHosts.${cfg.domain}.extraConfig = ''
        reverse_proxy ${cfg.host}:${toString cfg.port}
      '';
    };
  };
}
