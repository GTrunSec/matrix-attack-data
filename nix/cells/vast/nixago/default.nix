{ inputs, cell }@args:
let
  inherit (inputs) std;
in
builtins.mapAttrs (_: std.lib.dev.mkNixago) {
  vast-integation = {
    data = import ./vast-integation.nix args;
    output = "contents/conf/vast-integation.yaml";
    format = "yaml";
    hook.mode = "copy";
  };
}
