{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) lib;

  data = v:
    cell.lib.mapAttrsToString (l.getAttrFromPath v (
      inputs.cells.zeek.config.pop3
      // inputs.cells.zeek.config.geoip
    ));
in
  lib.writeVastSchema "zeek-pop3.schema" {
    config = {
      "zeek.pop3" = data [];
      id = data ["id"];
      location_orig = data ["location_orig"];
      location_resp = data ["location_resp"];
    };
    fixConfig = {} // lib.alias.zeek;
  }
