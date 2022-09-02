{
  inputs,
  cell,
} @ args: let
  inherit (inputs) std;
in
  builtins.mapAttrs (_: std.std.lib.mkNixago) {
    vast-integation = {
      configData = import ./vast-integation.nix args;
      output = "conf/vast-integation.yaml";
      format = "yaml";
      hook.mode = "copy";
    };
  }
