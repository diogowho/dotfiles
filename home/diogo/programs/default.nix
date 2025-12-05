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
    ./fzf.nix
    ./ripgrep.nix
    ./vesktop.nix
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
      github-copilot-cli
      pnpm_9
      ;
  };
}
