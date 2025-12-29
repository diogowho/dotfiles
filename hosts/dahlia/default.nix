{
  imports = [
    ./disko.nix
    ./hardware.nix
    ./networking.nix
  ];

  sys = {
    profiles.headless.enable = true;

    services = {
      # keep-sorted start
      node-exporter.enable = true;
      postgresql.enable = true;
      # keep-sorted end
    };

    networking.tailscale.enable = true;
  };

  system.stateVersion = "25.11";
}
