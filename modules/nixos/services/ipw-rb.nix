{
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
  options.sys.services.ipw-rb = mkServiceOption "ipw-rb" { };

  config = mkIf cfg.enable {
    services.ipw-rb.enable = true;
  };
}
