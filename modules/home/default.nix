{
  _class = "homeManager";

  imports = [
    # keep-sorted start
    ../shared/packages.nix
    ../shared/profiles.nix
    ./home.nix
    ./profiles.nix
    ./secrets.nix
    ./shell.nix
    # keep-sorted end
  ];
}
