{
  inputs,
  ...
}:
{
  imports = [ inputs.diogonvim.homeModules.default ];

  programs.diogo-nvim = {
    enable = true;
    defaultEditor = true;
  };
}
