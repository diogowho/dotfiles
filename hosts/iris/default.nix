{
  imports = [
    ./hardware.nix
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
    };

    networking = {
      tailscale.enable = true;

      cloud = {
        interface = "ens3";
        ipv4 = "51.75.255.245";
        ipv6 = "2001:41d0:305:2100::7785";
        gateway4 = "51.75.248.1";
        gateway6 = "2001:41d0:305:2100::1";
      };
    };
  };

  system.stateVersion = "25.05";
}
