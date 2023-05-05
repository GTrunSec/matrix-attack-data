{
  inputs,
  cell,
}: let
  inherit (inputs.std-ext.writers.lib) writeShellApplication writeConfig;
  inherit (inputs) nixpkgs;
in {
  check = writeShellApplication {
    name = "check-schema";
    runtimeInputs = [nixpkgs.check-jsonschema];
    text = ''
      check-jsonschema --schemafile ${writeConfig "phishing-features.json" cell.jsonschemas.phishing-features} ${writeConfig "phishing-features-schema.json" cell.jsonschemas.phishing-features}
    '';
  };
}
