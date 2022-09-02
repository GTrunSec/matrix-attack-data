{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) library;

  data = v: cell.library.mapAttrsToString (l.getAttrFromPath v (inputs.cells.zeek.config.conn));
in
  library.writeVastSchema "zeek-conn.schema" {
    config = {
      "zeek.conn" = data [];
      id = data [ "id" ];
    };
    fixConfig = {};
  }
