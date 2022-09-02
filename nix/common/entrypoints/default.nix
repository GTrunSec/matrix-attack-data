{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab._writers.library) writeShellApplication;
  inherit (inputs) nixpkgs;
in {
  check = writeShellApplication {
    name = "check-schema";
    runtimeInputs = [nixpkgs.check-jsonschema];
    text = ''
      check-jsonschema --schemafile ${cell.library.toJSON cell.jsonschemas.phishing-features} ${cell.library.toJSON cell.jsonschemas.phishing-features}
    '';
  };
}
