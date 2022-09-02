{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) library;

  data = v: cell.library.mapAttrsToString (l.getAttrFromPath v (inputs.cells.zeek.config.pop3));
in
  library.writeVastSchema "zeek-pop3.schema" {
    config = {
      "zeek.pop3" = data [];
      id = data ["id"];
    };
    fixConfig = {};
  }
