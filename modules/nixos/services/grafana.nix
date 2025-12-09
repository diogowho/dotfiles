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
    sops.secrets.grafana = {
      sopsFile = "${self}/secrets/services/grafana.yaml";
      owner = "grafana";
      group = "grafana";
    };

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

          security.disable_gravatar = true;

          auth = {
            oauth_allow_insecure_email_lookup = true;

            "generic_oauth" = {
              enabled = true;
              client_id = "fc40c281-9f05-4907-8c85-17c265fbc7c5";
              client_secret = "$__file{${config.sops.secrets.grafana.path}}";
              scopes = "openid profile email";
              auth_url = "https://id.diogocastro.net/authorize";
              token_url = "https://id.diogocastro.net/api/oidc/token";
              api_url = "";
              signout_redirect_url = "";
              allow_sign_up = false;
              auto_login = false;
              email_attribute_name = "email:primary";
              skip_org_role_sync = false;
            };
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
