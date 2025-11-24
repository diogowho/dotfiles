{ config, ... }:
{
  imports = [
    ./fail2ban.nix
    ./firewall.nix
    ./openssh.nix
  ];

  networking = {
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);

    networkmanager.enable = true;

    nameservers = [
      "9.9.9.9"
      "1.1.1.1"
      "2620:fe::fe"
      "2606:4700:4700::1111"
    ];
  };
}
