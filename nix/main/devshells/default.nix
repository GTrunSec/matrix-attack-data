{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.std.lib.mkShell) {
    default = {...}: {
      name = "default: Matrix Of Attack Data";
      imports = [
        inputs.cells-lab.main.devshellProfiles.default
      ];

      nixago = [cell.nixago.mdbook] ++ l.attrValues inputs.cells.vast.nixago;
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
