{ lib, config, ... }:
let
  inherit (lib)
    mkForce
    mkOption
    mkIf
    types
    ;
  cfg = config.sys.networking.cloud;
in
{
  options.sys.networking.cloud = {
    interface = mkOption {
      type = types.str;
      default = "ens3";
      description = "The network interface to configure.";
    };

    ipv4 = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "The IPv4 address to assign.";
    };

    ipv6 = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "The IPv6 address to assign.";
    };

    gateway4 = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "The IPv4 default gateway.";
    };

    gateway6 = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "The IPv6 default gateway.";
    };
  };

  config = {
    networking = {
      # Apply Default Gateways only if they are defined
      defaultGateway = mkIf (cfg.gateway4 != null) {
        address = cfg.gateway4;
        interface = cfg.interface;
      };

      defaultGateway6 = mkIf (cfg.gateway6 != null) {
        address = cfg.gateway6;
        interface = cfg.interface;
      };

      dhcpcd.enable = mkForce false;
      useDHCP = mkForce false;

      # usePredictableInterfaceNames = mkForce false;

      interfaces.${cfg.interface} = {
        ipv4 = mkIf (cfg.ipv4 != null) {
          addresses = [
            {
              address = cfg.ipv4;
              prefixLength = 32;
            }
          ];

          routes = mkIf (cfg.gateway4 != null) [
            {
              address = cfg.gateway4;
              prefixLength = 32;
              options.scope = "link";
            }
          ];
        };

        ipv6 = mkIf (cfg.ipv6 != null) {
          addresses = [
            {
              address = cfg.ipv6;
              prefixLength = 128;
            }
          ];

          routes = mkIf (cfg.gateway6 != null) [
            {
              address = cfg.gateway6;
              prefixLength = 128;
              options.scope = "link";
            }
          ];
        };
      };
    };
  };
}
