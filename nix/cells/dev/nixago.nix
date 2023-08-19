{ inputs, cell }:
let
  inherit (inputs) std std-ext;
  inherit (inputs.std.lib.dev) mkNixago;
in
{
  mdbook = mkNixago std.lib.cfg.mdbook {
    hook.mode = "copy";
    data = {
      book.title = "Martix Of attack data";
    };
  };

  treefmt = std-ext.presets.nixago.treefmt {
    data.formatter.nix = {
      excludes = [ "generated.nix" ];
    };
    data.formatter.prettier = {
      excludes = [
        "contents/*"
        "generated.json"
        "generated_attck_data.json"
      ];
    };
  };
}
