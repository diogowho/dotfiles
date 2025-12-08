{ pkgs, config, ... }:
{
  config = {
    networking.firewall = {
      enable = true;
      package = pkgs.iptables;

      allowedTCPPorts = [
        443
        80
      ];
      allowedUDPPorts = [ ];

      allowedTCPPortRanges = [ ];
      allowedUDPPortRanges = [ ];

      allowPing = config.sys.profiles.headless.enable;

      logReversePathDrops = true;
      logRefusedConnections = false;
    };
  };
}
