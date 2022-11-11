{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "default: Matrix Of Attack Data";
      imports = [
        inputs.cells-lab._automation.devshellProfiles.default
      ];

      nixago = [cell.nixago.mdbook cell.nixago.treefmt] ++ l.attrValues inputs.cells.vast.nixago;

      devshell.startup.cpSchemas = let
        vastSchemas = l.concatStrings (map (a: ''
            cp -rf --no-preserve=mode,ownership ${a} \
            $PRJ_ROOT/data/vast/${a.name}
          '')
          (l.attrValues
            inputs.cells.vast.schemas));
      in
        l.stringsWithDeps.noDepEntry ''
          ${vastSchemas}
        '';
    };
    doc = {
      name = "mkdocs";

      std.adr.enable = false;

      imports = [
        inputs.std.std.devshellProfiles.default
      ];
      nixago = [
        cell.nixago.mdbook
      ];
    };
  }
