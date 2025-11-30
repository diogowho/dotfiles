{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };

    optimise.automatic = true;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      warn-dirty = false;
    };
  };
  nixpkgs.config.allowUnfree = true;
}
