{
  imports = [
    ./hardware.nix
  ];

  sys = {
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
      asf.enable = true;
      pocket-id.enable = true;
    };
    networking.wireguard.enable = true;
  };

  system.stateVersion = "25.05";
}
