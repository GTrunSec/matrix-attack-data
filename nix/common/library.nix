{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
  inherit (inputs.cells-lab._writers.library) writeConfiguration;
in rec {
  filterValue = v': attrsSet: let
    checkValue = val: l.isAttrs val && l.hasAttr v' val && val != "object";
  in
    l.mapAttrsRecursiveCond (as: (!checkValue as)) (p: v:
      if checkValue v
      then v.value
      else v)
    attrsSet;

  toJsonSchema = arg: attr: (builtins.mapAttrs (
    n: v:
      if (l.hasAttr "properties" v.schemas.data.validation)
      then {
        type = "object";
        inherit (v.schemas.${arg}.validation) properties;
      }
      else v.schemas.${arg}.validation
  ) (filterValue "value" attr));

  toJSON = source:
    (writeConfiguration {
      name = "toJSON";
      format = "json";
      language = "nix";
      inherit source;
    })
    .data;
}
