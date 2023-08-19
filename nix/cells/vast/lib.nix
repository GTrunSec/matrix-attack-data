{ inputs, cell }:
let
  l = inputs.nixpkgs.lib // builtins;
in
{
  mapAttrsToString =
    attrsSet:
    let
      checkValue = val: l.isAttrs val || l.isList val;
    in
    l.mapAttrsRecursiveCond (as: (!checkValue as))
      (
        p: v:
        if checkValue v then
          if (l.isList v) then "list<${l.concatStrings p}>" else "${l.concatStrings p}"
        else
          v
      )
      (if l.isList attrsSet then l.head attrsSet else attrsSet);
}
