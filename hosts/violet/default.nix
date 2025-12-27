{
  sys = {
    profiles = {
      graphical.enable = true;
      laptop.enable = true;
    };

    services.yabai.enable = true;

    networking.netbird.enable = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
