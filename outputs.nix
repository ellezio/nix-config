{ nixpkgs, ... }@inputs:
let
  system = "x86_64-linux";
  username = "pawellendzion";
  userFullName = "Paweł Lendzion";

  mylib = import ./lib { inherit (nixpkgs) lib; };

  specialArgs = inputs // {
    inherit username userFullName mylib;

    upkgs = import inputs.nixpkgs-user {
      inherit system;
      config.allowUnfree = true;
      config.nvidia.acceptLicense = true;
    };
  };

  nixosSystem = mylib.nixosSystemWith { inherit inputs specialArgs system username; };

  plendzion-config = (import ./hosts/plendzion (inputs // {
    inherit nixosSystem;
  })).nixosConfigurations;

  ellezio-config = (import ./hosts/ellezio (inputs // {
    inherit nixosSystem;
  })).nixosConfigurations;
in
{
  nixosConfigurations = plendzion-config // ellezio-config;
}
