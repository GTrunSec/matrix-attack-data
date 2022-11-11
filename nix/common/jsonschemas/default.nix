{
  inputs,
  cell,
} @ args: let
  inherit (cell) config lib;
in {
  phishing-features = {
    "$id" = "phishing-url";
    "$schema" = "phishing-url-schema";
    "description" = "A phishing Url schema";
    "type" = "object";
    "properties" = lib.toJsonSchema "data" config.phishing-features;
  };
}
