{
  inputs,
  cell,
}: let
  inherit (inputs) std;
in {
  mdbook = std.presets.nixago.mdbook {
    data = {
      book.title = "Martix Of attack data";
    };
  };

  treefmt = std.presets.nixago.treefmt {
    data.formatter.nix = {
      excludes = [
        "generated.nix"
      ];
    };
    data.formatter.prettier = {
      excludes = [
        "conf/*"
        "data/*"
        "generated.json"
        "generated_attck_data.json"
      ];
    };
  };
}
