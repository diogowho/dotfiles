# https://isabelroses.com/blog/nix-pds-guide/
{
  lib,
  self,
  config,
  ...
}:
let
  inherit (lib) mkIf concatStringsSep;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.pds;
in
{
  options.sys.services.pds = mkServiceOption "pds" {
    domain = "pds.${config.networking.domain}";
    port = 3333;
  };

  config = mkIf cfg.enable {
    sops.secrets.pds = {
      sopsFile = "${self}/secrets/services/pds.yaml";
      owner = "pds";
      group = "pds";
    };

    services = {
      bluesky-pds = {
        enable = true;
        pdsadmin.enable = true;

        environmentFiles = [ config.sops.secrets.pds.path ];

        settings = {
          PDS_PORT = cfg.port;
          PDS_HOSTNAME = cfg.domain;
          PDS_ADMIN_EMAIL = "hello@" + config.networking.domain;

          # https://compare.hose.cam
          PDS_CRAWLERS = concatStringsSep "," [
            "https://bsky.network"
            "https://relay.cerulea.blue"
            "https://relay.fire.hose.cam"
            "https://relay2.fire.hose.cam"
            "https://relay3.fr.hose.cam"
            "https://relay.hayescmd.net"
            "https://relay.xero.systems"
            "https://relay.upcloud.world"
            "https://relay.feeds.blue"
            "https://atproto.africa"
          ];

          PDS_OAUTH_PROVIDER_NAME = config.networking.domain;
        };
      };

      caddy.virtualHosts.${cfg.domain} = {
        extraConfig = ''
          reverse_proxy http://${cfg.host}:${toString cfg.port}

          handle /xrpc/app.bsky.unspecced.getAgeAssuranceState {
            header content-type "application/json"
            header access-control-allow-headers "authorization,dpop,atproto-accept-labelers,atproto-proxy"
            header access-control-allow-origin "*"
            respond `{"lastInitiatedAt":"2025-07-14T14:22:43.912Z","status":"assured"}` 200
          }
        '';
      };
    };
  };
}
