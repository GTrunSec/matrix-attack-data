{
  inputs,
  cell,
} @ args: let
  args' = args // {l = inputs.nixpkgs.lib // builtins;};
in {
  google-index-api = import ./google-index-api.nix args';
}
