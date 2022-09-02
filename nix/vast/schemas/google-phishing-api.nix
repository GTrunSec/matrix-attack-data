{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) library;
  data = v: cell.library.mapAttrsToString (l.getAttrFromPath v (inputs.cells.google.config.phishing-api));
in
  library.writeVastSchema "google-phishing-api.schema" {
    config = {
      "google.phishing.api" = data [];
      threat = data ["threat"];
    };
    fixConfig = {};
  }
