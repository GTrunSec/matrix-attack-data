{
  inputs,
  cell,
}: let
  inherit (inputs) std;
in {
  mdbook = std.std.nixago.mdbook {
    configData = {
      book.title = "Martix Of attack data";
    };
  };

  treefmt = std.std.nixago.treefmt {
    configData.formatter.nix = {
      excludes = [
        "generated.nix"
      ];
    };
    configData.formatter.prettier = {
      excludes = [
        "conf/*"
        "data/*"
      ];
    };
  };
}
