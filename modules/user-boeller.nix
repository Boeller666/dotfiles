{ ... }:
{

  users.users.boeller = {
    isNormalUser = true;
    description = "René Gärtner";
    extraGroups = [ "networkmanager" "wheel" ];
    extraSpecialArgs = {
      inherit inputs;
    };
  };

  nix.settings.trusted-users = [ "@wheel" ];

}