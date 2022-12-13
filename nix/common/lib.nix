{
  inputs,
  cell,
}: let
  inherit (inputs) std self;
  inherit (inputs.cells-lab.common.lib) callFlake;

  l = inputs.nixpkgs.lib // builtins;

  __inputs__ = callFlake "${(std.incl self ["lock"])}/lock" {
    nixpkgs.locked = inputs.nixpkgs-lock.sourceInfo;
    # add channel follows
    POP.nixpkgs.follows = "nixpkgs";
  };
in rec {
  inherit __inputs__ l;

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
