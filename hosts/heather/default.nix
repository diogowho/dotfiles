{
  imports = [
    ./hardware.nix
  ];

  sys = {
    profiles.headless.enable = true;
    services = {
      postgresql.enable = true;
    };
    networking.tailscale.enable = true;
  };

  system.stateVersion = "25.11";
}
