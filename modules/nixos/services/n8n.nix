{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.n8n;
in
{
  options.sys.services.n8n = mkServiceOption "n8n" {
    domain = "n8n.${config.networking.domain}";
    port = 5678;
  };

  config = mkIf cfg.enable {
    services = {
      n8n = {
        enable = true;

        environment = {
          N8N_HOST = cfg.domain;
          N8N_PORT = cfg.port;
          N8N_PROTOCOL = "https";
          N8N_HIRING_BANNER_ENABLED = "false";
          DB_TYPE = "postgresdb";
          DB_POSTGRESDB_USER = "n8n";
          DB_POSTGRESDB_PASSWORD = "n8n";
        };
      };

      postgresql = {
        ensureDatabases = [ "n8n" ];
        ensureUsers = lib.singleton {
          name = "n8n";
          ensureDBOwnership = true;
        };
      };

      caddy.virtualHosts.${cfg.domain}.extraConfig = ''reverse_proxy ${cfg.host}:${toString cfg.port}'';
    };
  };
}
