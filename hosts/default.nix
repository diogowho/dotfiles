{ self, inputs, ... }:
{
  imports = [ inputs.easy-hosts.flakeModule ];

  config.easy-hosts = {
    perClass = class: {
      modules = [ "${self}/modules/${class}" ];
    };

    hosts = {
      violet = {
        arch = "aarch64";
        class = "darwin";
      };

      iris = { };
    };
  };
}
