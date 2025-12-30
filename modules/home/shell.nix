{ config, ... }:
{
  home.shell = {
    enableShellIntegration = false;

    enableZshIntegration = config.programs.zsh.enable;
  };
}
