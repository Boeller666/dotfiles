{ pkgs, username, ... }:
{
  home-manager.users.${username}.home.packages = with pkgs; [
    bitwarden-cli
    bitwarden-desktop
  ]
}
