{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) lib;

  data = v: cell.lib.mapAttrsToString (l.getAttrFromPath v (inputs.cells.zeek.config.conn));
in
  lib.writeVastSchema "zeek-conn.schema" {
    config = {
      "zeek.conn" = data [];
      id = data ["id"];
    };
    fixConfig = {} // lib.alias.zeek;
  }
