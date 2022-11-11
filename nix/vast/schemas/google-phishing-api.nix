{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) lib;
  data = v: cell.lib.mapAttrsToString (l.getAttrFromPath v (inputs.cells.google.config.phishing-api));
in
  lib.writeVastSchema "google-phishing-api.schema" {
    config = {
      "google.phishing.api" = data [];
      threat = data ["threat"];
    };
    fixConfig = {};
  }
