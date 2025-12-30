{ config, ... }:
{
  programs.lazygit = {
    enable = config.programs.git.enable && config.sys.profiles.graphical.enable;
  };
}
