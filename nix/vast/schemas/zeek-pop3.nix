{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) library;

  data = v:
    cell.library.mapAttrsToString (l.getAttrFromPath v (
      inputs.cells.zeek.config.pop3
      // inputs.cells.zeek.config.geoip
    ));
in
  library.writeVastSchema "zeek-pop3.schema" {
    config = {
      "zeek.pop3" = data [];
      id = data ["id"];
      location_orig = data ["location_orig"];
      location_resp = data ["location_resp"];
    };
    fixConfig = {} // library.alias.zeek;
  }
