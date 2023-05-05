{
  inputs,
  cell,
}: let
  inherit (inputs.std-ext.writers.lib) writeShellApplication writeConfig;
  inherit (inputs) nixpkgs;

  data-jsonschema = writeConfig "phishing-url-data-jsonschema.json" cell.jsonschemas.phishing-url-data-jsonschema;
in {
  check = writeShellApplication {
    name = "check-phihsing-url-data-schema";
    runtimeInputs = [nixpkgs.check-jsonschema];
    text = ''
      check-jsonschema --schemafile ${data-jsonschema} ${writeConfig "phishing-url-data.json" cell.config.phishing-url-data}
    '';
  };
  check-data = writeShellApplication {
    name = "check-true-phihsing-url-data-schema";
    runtimeInputs = [nixpkgs.check-jsonschema nixpkgs.jq];
    text = ''
      echo "checking Phishing URL Data from Spider Applicaion"
      for n in $(seq 0 6);
      do
          jq -ec ".[$n]" "$PRJ_ROOT"/data/phishing/true-phishing-url-data.json > /tmp/check-true-data.json
          check-jsonschema --schemafile ${data-jsonschema} /tmp/check-true-data.json
      done
      # for n in $(seq 0 2);
      # do
      #     jq -ec ".[$n]" "$PRJ_ROOT"/conf/true-phishing-url-data.json > /tmp/check-true-data.json
      #     check-jsonschema --schemafile ${data-jsonschema} /tmp/check-true-data.json
      # done
    '';
  };
}
