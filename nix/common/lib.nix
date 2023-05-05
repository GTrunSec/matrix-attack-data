{
  inputs,
  cell,
}: let
  inherit (inputs) std flops nixpkgs;
  inherit (inputs.std-ext.common.lib) callFlake;

  l = inputs.nixpkgs.lib // builtins;

  callInputs = ((flops.lib.flake.pops.default.setInitInputs ./lib/lock)
    .setSystem
    nixpkgs.system)
  .addInputsOverride {
  };
in rec {
  inherit callInputs l;

  __inputs__ = callInputs.outputsForInputsCompat;

  filterValue = v': attrsSet: let
    checkValue = val: l.isAttrs val && l.hasAttr v' val && val != "object";
  in
    l.mapAttrsRecursiveCond (as: (!checkValue as)) (p: v:
      if checkValue v
      then v.value
      else v)
    attrsSet;

  toJsonSchema = attr: attrsSet: (builtins.mapAttrs (
    n: v:
      if (l.hasAttr "properties" v.schemas.data.validation)
      then {
        type = "object";
        inherit (v.schemas.${attr}.validation) properties;
      }
      else v.schemas.${attr}.validation
  ) (filterValue "value" attrsSet));
}
