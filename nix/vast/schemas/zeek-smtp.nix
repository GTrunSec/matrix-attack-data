{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) library;

  data = v: cell.library.mapAttrsToString (l.getAttrFromPath v (inputs.cells.zeek.config.smtp));
in
  library.writeVastSchema "zeek-smtp.schema" {
    config = {
      "zeek.smtp" = data [];
      id = data ["id"];
    };
    fixConfig = {};
  }
