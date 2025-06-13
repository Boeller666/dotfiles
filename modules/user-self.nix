{ username, ... }:
{

  users.users.${username} = {
    isNormalUser = true;
    description = "René Gärtner";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix.settings.trusted-users = [ "@wheel" ];

}
