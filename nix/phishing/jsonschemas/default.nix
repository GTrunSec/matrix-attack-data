{
  inputs,
  cell,
}: let
  inherit (cell) config;
  inherit (inputs.cells.common) lib;
in {
  phishing-url-data-jsonschema = {
    "$id" = "phishing-url-data";
    "$schema" = "phishing-url-data-schema";
    "description" = "A phishing Url Data schema";
    "type" = "object";
    "properties" = lib.toJsonSchema "data" config.phishing-features;
  };

  phishing-url-result-jsonschema = {
    "$id" = "phishing-url-result";
    "$schema" = "phishing-url-result-schema";
    "description" = "A phishing Url result schema";
    "type" = "object";
    "properties" = builtins.mapAttrs (n: v: v.schemas.result.validation) cell.config.phishing-features;
  };
}
