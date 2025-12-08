{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.grafana;
in
{
  options.sys.services.grafana = mkServiceOption "grafana" {
    domain = "metrics.${config.networking.domain}";
    port = 3003;
  };

  config = mkIf cfg.enable {
    services = {
      grafana = {
        enable = true;

        settings = {
          server = {
            root_url = "https://${cfg.domain}";
            domain = cfg.domain;
            http_port = cfg.port;
            http_addr = cfg.host;
            enforce_domain = true;
            enable_gzip = true;
          };

          database = {
            type = "postgres";
            host = "localhost:5432";
            name = "grafana";
            user = "grafana";
            password = "grafana";
          };
        };

        provision.datasources.settings.datasources = [
          {
            name = "Prometheus";
            type = "prometheus";
            url = "https://${cfg.domain}/prometheus";
            isDefault = true;
          }
        ];
      };

      prometheus = {
        enable = true;
        listenAddress = cfg.host;
        port = 9090;
        webExternalUrl = "https://${cfg.domain}/prometheus";

        scrapeConfigs = [
          {
            job_name = "node";
            static_configs = [
              {
                targets = [ "localhost:9100" ];
              }
            ];
          }
          {
            job_name = "grafana";
            static_configs = [
              {
                targets = [ "localhost:${toString cfg.port}" ];
              }
            ];
          }
        ];

        exporters.node.enable = true;
      };

      postgresql = {
        ensureDatabases = [ "grafana" ];
        ensureUsers = lib.singleton {
          name = "grafana";
          ensureDBOwnership = true;
        };
      };

      caddy.virtualHosts.${cfg.domain}.extraConfig = ''
        reverse_proxy ${cfg.host}:${toString cfg.port}

        @prometheus path /prometheus/*
        reverse_proxy @prometheus ${cfg.host}:9090
      '';
    };
  };
}
