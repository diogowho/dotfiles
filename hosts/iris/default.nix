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
      pocket-id.enable = true;
      website.enable = true;
      open-webui.enable = true;
    };
    networking.tailscale.enable = true;
  };

  system.stateVersion = "25.05";
}
