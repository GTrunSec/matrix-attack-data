{ inputs, cell }:
let
  inherit (inputs.cells.common.lib) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) lib;

  data =
    v:
    cell.lib.mapAttrsToString (l.getAttrFromPath v (inputs.cells.zeek.config.smtp));
in
lib.writeVastSchema "zeek-smtp.schema" {
  config = {
    "zeek.smtp" = data [ ];
    id = data [ "id" ];
  };
  fixConfig = { } // lib.alias.zeek;
}
