{ modulesPath, pkgs, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
  ];

  # Enables copy / paste when running in a KVM with spice.
  services.spice-vdagentd.enable = true;

  users.users.nixos.shell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    mkpasswd
    nixpkgs-fmt
    ripgrep
    tree
    xclip # for clipboard support in neovim
  ];

  home-manager.users.nixos = {
    home.stateVersion = "24.05";

    programs = {
      alacritty.enable = true;
      fzf.enable = true; # enables zsh integration by default
      starship.enable = true;

      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
      };

      neovim = {
        enable = true;
        extraConfig = builtins.readFile ./nvim/init.vim;
      };
    };
  };

  # Use faster squashfs compression
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
