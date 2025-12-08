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
    domain = "id.diogocastro.net";
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
          PORT = cfg.port;
          ANALYTICS_DISABLED = true;
          UI_CONFIG_DISABLED = true;
          ALLOW_USER_SIGNUPS = "withToken";
          ACCENT_COLOR = "#9A4CF6";
          EMAIL_API_KEY_EXPIRATION_ENABLED = true;
          EMAILS_VERIFIED = true;
          DB_PROVIDER = "postgres";
          KEYS_STORAGE = "database";
          FILE_BACKEND = "s3";
          UPLOAD_PATH = "pocket-id/uploads";
          DB_CONNECTION_STRING = "postgresql://pocketid:pocketid@localhost:5432/pocketid";
        };

        environmentFile = config.sops.secrets.pocket-id.path;
      };

      postgresql = {
        ensureDatabases = [ "pocketid" ];
        ensureUsers = lib.singleton {
          name = "pocketid";
          ensureDBOwnership = true;
        };
      };

      caddy.virtualHosts.${cfg.domain}.extraConfig = ''reverse_proxy ${cfg.host}:${toString cfg.port}'';
    };
  };
}
