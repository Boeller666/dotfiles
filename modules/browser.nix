{ pkgs, username, ...}:
{
  home-manager.users.${username}.programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
    ]
  }

  home-manager.users.${username}.xdg.desktopEntries."brave" = {
    name = "Brave";
    genericName = "Browser";
    exec = "brave";
    terminal = false;
  };
}
