{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) library;

  data = v: cell.library.mapAttrsToString (l.getAttrFromPath v (inputs.cells.zeek.config.imap));
in
  library.writeVastSchema "zeek-imap.schema" {
    config = {
      "zeek.imap" = data [];
      id = data ["id"];
    };
    fixConfig = {};
  }
