{
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/25.05";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-user.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dw-proton.url = "github:imaviso/dwproton-flake";
  };

  outputs = inputs: import ./outputs.nix inputs;
}
