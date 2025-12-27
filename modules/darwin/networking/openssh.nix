{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.sys.networking.openssh;
in
{
  options.sys.networking.openssh.enable = mkEnableOption "OpenSSH";

  config = mkIf cfg.enable {
    services.openssh.enable = true;

    users.users.diogo.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICCTbCHJ0avif6MQ7izXlHHaubNsOhU2xf9lMvXKLyUQ"
    ];
  };
}
