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
      imports = [ cell.pops.devshellProfiles.exports.default.nickel ];

      nixago = [
        cell.nixago.treefmt.default
        cell.nixago.lefthook.default
        cell.nixago.conform.default
      ];

      # devshell.startup.cpSchemas =
      #   let
      #     vastSchemas = l.concatStrings (
      #       map
      #         (a: ''
      #           cp -rf --no-preserve=mode,ownership ${a} \
      #           $PRJ_ROOT/contents/data/vast/${a.name}
      #         '')
      #         (l.attrValues inputs.cells.vast.schemas)
      #     );
      #   in
      #   l.stringsWithDeps.noDepEntry ''
      #     ${vastSchemas}
      #   '';
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
