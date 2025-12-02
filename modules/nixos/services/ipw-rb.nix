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

  cfg = config.sys.services.ipw-rb;
in
{
  imports = [ inputs.ipw-rb.nixosModules.default ];

  options.sys.services.ipw-rb = mkServiceOption "ipw-rb" {
    domain = "rb.${config.networking.domain}";
  };

  config = mkIf cfg.enable {
    services.ipw-rb-website = {
      enable = true;
      domain = cfg.domain;
    };
  };
}
