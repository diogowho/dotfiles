{
  imports = [
    # keep-sorted start
    ./netbird.nix
    ./openssh.nix
    # keep-sorted end
  ];

  networking = {
    applicationFirewall = {
      enable = true;
      blockAllIncoming = false;
      allowSignedApp = false;
      allowSigned = true;
      enableStealthMode = true;
    };

    # networksetup -listallnetworkservices
    knownNetworkServices = [
      "Wi-Fi"
    ];

    dns = [
      "9.9.9.9"
      "1.1.1.2"
      "2620:fe::fe"
      "2606:4700:4700::1112"
    ];
  };
}
