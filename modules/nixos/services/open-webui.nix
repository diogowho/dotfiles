{
  inputs,
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.open-webui;
in
{
  options.sys.services.open-webui = mkServiceOption "open-webui" {
    domain = "ai.${config.networking.domain}";
    port = 1422;
  };

  config = mkIf cfg.enable {
    sops.secrets.open-webui = {
      sopsFile = "${self}/secrets/services/open-webui.yaml";
    };

    services = {
      open-webui = {
        enable = true;
        port = cfg.port;
        environment = {
          WEBUI_URL = "https://${cfg.domain}";
          ENABLE_SIGNUP = "false";
          ENABLE_PASSWORD_AUTH = "false";
          ENABLE_OAUTH_SIGNUP = "true";
          ENABLE_LOGIN_FORM = "false";
          OAUTH_SCOPES = "openid email profile groups";
          OAUTH_UPDATE_PICTURE_ON_LOGIN = "true";
          DEFAULT_USER_ROLE = "user";
          ENABLE_ADMIN_EXPORT = "false";
          ENABLE_ADMIN_CHAT_ACCESS = "false";
          DATABASE_TYPE = "postgresql";
          DATABASE_URL = "postgresql://openwebui:openwebui@localhost:5432/openwebui";
        };

        environmentFile = config.sops.secrets.open-webui.path;
      };

      postgresql = {
        ensureDatabases = [ "openwebui" ];
        ensureUsers = lib.singleton {
          name = "openwebui";
          ensureDBOwnership = true;
        };
      };

      caddy.virtualHosts.${cfg.domain}.extraConfig = ''reverse_proxy ${cfg.host}:${toString cfg.port}'';
    };
  };
}
