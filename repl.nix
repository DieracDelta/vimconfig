let
  flake = builtins.getFlake (toString ./.);
  nixpkgs = flake.inputs.nixpkgs;
  pkgs = import nixpkgs { system = "x86_64-linux"; };
in
{
  inherit pkgs flake;
  inherit (flake.inputs) self;
}
