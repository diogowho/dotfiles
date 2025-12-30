{ pkgs, ... }:
{
  sys.packages = {
    inherit (pkgs)
      # keep-sorted start
      age
      just
      nil
      nixd
      sops
      # keep-sorted end
      ;
  };
}
