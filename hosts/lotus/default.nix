{
  imports = [
    ./disko.nix
    ./hardware.nix
    ./networking.nix
  ];

  sys = {
    profiles.headless.enable = true;

    services = {
      # keep-sorted start block=yes
      caddy.enable = true;
      grafana = {
        enable = true;
        scrapeTargets = [ "100.100.20.2:9100" ];
      };
      node-exporter.enable = true;
      website.enable = true;
      pocket-id.enable = true;
      # keep-sorted end
    };

    networking.netbird.enable = true;
  };

  system.stateVersion = "25.11";
}
