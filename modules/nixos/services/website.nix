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

  cfg = config.sys.services.website;
in
{
  imports = [ inputs.website.nixosModules.default ];

  options.sys.services.website = mkServiceOption "website" {
    domain = config.networking.domain;
  };

  config = mkIf cfg.enable {
    services.diogocastro-website = {
      enable = true;
      domain = cfg.domain;
    };
  };
}
