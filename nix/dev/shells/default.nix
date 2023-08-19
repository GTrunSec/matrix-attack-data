{ inputs, cell }:
let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
l.mapAttrs (_: std.lib.dev.mkShell) {
  default =
    { ... }:
    {
      name = "default: Matrix Of Attack Data";
      imports = [ inputs.std-ext.automation.devshellProfiles.default ];

      nixago = [
        cell.nixago.mdbook
        cell.nixago.treefmt
      ];

      devshell.startup.cpSchemas =
        let
          vastSchemas = l.concatStrings (
            map
              (a: ''
                cp -rf --no-preserve=mode,ownership ${a} \
                $PRJ_ROOT/data/vast/${a.name}
              '')
              (l.attrValues inputs.cells.vast.schemas)
          );
        in
        l.stringsWithDeps.noDepEntry ''
          ${vastSchemas}
        '';
    };
  doc = {
    name = "mkdocs";
    imports = [ inputs.std.std.devshellProfiles.default ];
    nixago = [ cell.nixago.mdbook ];
  };

  generator = {
    name = "generator";

    nixago =
      l.attrValues inputs.cells.vast.nixago
      ++ l.attrValues inputs.cells.phishing.lib.nixago;
  };
}
