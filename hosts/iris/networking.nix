let
  mainIf = "ens3";
in
{
  networking = {
    useDHCP = false;

    interfaces.${mainIf} = {
      useDHCP = false;

      ipv4.addresses = [
        {
          address = "51.75.255.245";
          prefixLength = 32;
        }
      ];

      ipv6.addresses = [
        {
          address = "2001:41d0:305:2100::7785";
          prefixLength = 128;
        }
      ];
    };

    defaultGateway = "51.75.248.1";

    defaultGateway6 = {
      address = "2001:41d0:305:2100::1";
      interface = mainIf;
    };
  };
}
