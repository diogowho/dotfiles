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
    domain = "metrics.diogocastro.net";
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
        };

        provision.datasources.settings.datasources = [
          {
            name = "Prometheus";
            type = "prometheus";
            url = "http://${cfg.host}:9090";
            isDefault = true;
          }
        ];
      };

      prometheus = {
        enable = true;
        listenAddress = "${cfg.host}:9090";
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

      caddy.virtualHosts.${cfg.domain}.extraConfig = ''
        reverse_proxy ${cfg.host}:${toString cfg.port}

        @prometheus path /prometheus/*
        reverse_proxy @prometheus ${cfg.host}:9090
      '';
    };
  };
}
