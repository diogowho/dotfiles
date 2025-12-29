{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    ;

  inherit (config.services) tailscale;

  cfg = config.sys.networking.tailscale;
in
{
  options = {
    sys.networking.tailscale.enable = mkEnableOption "Tailscale";
  };

  config = mkIf cfg.enable {
    sys.packages = { inherit (pkgs) tailscale; };

    networking.firewall = {
      trustedInterfaces = [ "${tailscale.interfaceName}" ];
      checkReversePath = "loose";
      allowedUDPPorts = [ tailscale.port ];
    };

    services.tailscale = {
      enable = true;
      permitCertUid = "root";
    };
  };
}
