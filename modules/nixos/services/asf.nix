{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.asf;
in
{
  options.sys.services.asf = mkServiceOption "asf" {
    port = 1242;
  };

  config = mkIf cfg.enable {
    sops.secrets.asf-ipc = {
      sopsFile = "${self}/secrets/services/asf.yaml";
      key = "ipc";
      owner = "archisteamfarm";
      group = "archisteamfarm";
    };

    services = {
      archisteamfarm = {
        enable = true;

        settings = {
          SteamOwnerID = 76561198950840617;
          Statistics = false;
        };

        web-ui.enable = true;

        ipcSettings = {
          Kestrel = {
            Endpoints = {
              HTTP = {
                Url = "http://*:${toString cfg.port}";
              };
            };
          };
        };

        ipcPasswordFile = config.sops.secrets.asf-ipc.path;
      };
    };
  };
}
