{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./fastfetch
    ./zsh.nix
    ./ohmyposh
    ./btop.nix
    ./neovim
    ./tmux.nix
    ./zen.nix
    ./fzf.nix
    ./ripgrep.nix
    ./vesktop.nix
    ./zed.nix
    ./ghostty.nix
  ];

  sys.packages = {
    inherit (pkgs)
      nodejs
      just
      bun
      age
      sops
      go
      rustc
      cargo
      ;
  };
}
