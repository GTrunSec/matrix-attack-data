{ inputs, cell }@args:
let
  inherit (inputs) nixpkgs;
  zeek = import ./zeek.nix args;
  API = import ./API.nix args;
in
{
  tests = zeek // API // { };
}
