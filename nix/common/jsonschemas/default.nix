{
  inputs,
  cell,
} @ args: let
  inherit (cell) config library;
in {
  phishing-features = {
    "$id" = "phishing-url";
    "$schema" = "phishing-url-schema";
    "description" = "A phishing Url schema";
    "type" = "object";
    "properties" = library.toJsonSchema "data" config.phishing-features;
  };
}
