{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) lib;

  data = v: cell.lib.mapAttrsToString (l.getAttrFromPath v (inputs.cells.zeek.config.imap));
in
  lib.writeVastSchema "zeek-imap.schema" {
    config = {
      "zeek.imap" = data [];
      id = data ["id"];
    };
    fixConfig = {} // lib.alias.zeek;
  }
