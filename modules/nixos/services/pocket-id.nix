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
  options = {
    sys.services.pocket-id = mkServiceOption "pocket-id" {
      domain = "sso.${config.networking.domain}";
      port = 1411;
    };
  };

  config = mkIf cfg.enable {
    users.groups.pocketid-data = { };
    users.users."pocket-id".extraGroups = [ "pocketid-data" ];
    users.users."litestream".extraGroups = [ "pocketid-data" ];

    systemd.tmpfiles.rules = [
      "Z /var/lib/pocket-id 0770 pocket-id pocketid-data -"
      "Z /var/lib/pocket-id/data 0770 pocket-id pocketid-data -"
      "f /var/lib/pocket-id/data/pocket-id.db 0660 pocket-id pocketid-data -"
    ];

    sops.secrets.pocket-id = {
      sopsFile = "${self}/secrets/services/pocket-id.yaml";
      owner = "pocket-id";
      group = "pocket-id";
    };

    sops.secrets.litestream = {
      sopsFile = "${self}/secrets/services/litestream.yaml";
    };

    services = {
      pocket-id = {
        enable = true;

        settings = {
          APP_URL = "https://${cfg.domain}";
          PORT = cfg.port;
          ANALYTICS_DISABLED = true;
          UI_CONFIG_DISABLED = true;
          ALLOW_USER_SIGNUPS = "withToken";
          ACCENT_COLOR = "#9A4CF6";
          EMAIL_API_KEY_EXPIRATION_ENABLED = true;
          EMAILS_VERIFIED = true;
        };

        environmentFile = config.sops.secrets.pocket-id.path;
      };

      litestream = {
        enable = true;

        settings = {
          dbs = [
            {
              path = "/var/lib/pocket-id/data/pocket-id.db";
              replicas = [
                {
                  type = "s3";
                  bucket = "dahlia";
                  path = "pocket-id.db";
                  endpoint = "https://s3.gra.io.cloud.ovh.net/";
                  region = "gra";
                  force-path-style = true;
                }
              ];
            }
          ];
        };

        environmentFile = config.sops.secrets.litestream.path;
      };

      caddy.virtualHosts.${cfg.domain}.extraConfig = ''reverse_proxy ${cfg.host}:${toString cfg.port}'';
    };
  };
}
