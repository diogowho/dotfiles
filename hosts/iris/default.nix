{
  imports = [
    ./hardware.nix
    ./networking.nix
  ];

  sys = {
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
      postgresql.enable = true;
      asf.enable = true;
      pocket-id.enable = true;
      website.enable = true;
      n8n.enable = true;
      grafana.enable = true;

      ipw-rb.enable = true;
      kowo.enable = true;
    };

    networking.tailscale.enable = true;
  };

  system.stateVersion = "25.05";
}
