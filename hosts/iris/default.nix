{
  imports = [
    ./hardware.nix
    ./networking.nix
  ];

  sys = {
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
      asf.enable = true;
    };
  };

  system.stateVersion = "25.05";
}
