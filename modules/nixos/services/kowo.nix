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

  cfg = config.sys.services.kowo;
in
{
  imports = [ inputs.kowo.nixosModules.default ];

  options.sys.services.kowo = mkServiceOption "kowo" { };

  config = mkIf cfg.enable {
    services.kowo.enable = true;
  };
}
