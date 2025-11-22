{
  imports = [
    ./hardware.nix
  ];

  sys = {
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
      asf.enable = true;
    };
    networking.wireguard.enable = true;
  };

  system.stateVersion = "25.05";
}
