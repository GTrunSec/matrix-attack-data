{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) library;
  data = v: cell.library.mapAttrsToString (l.getAttrFromPath v (inputs.cells.google.config.index-api));
in
  library.writeVastSchema "google-index-api.schema" {
    config = {
      "google.index.api" = data [];
      url = data ["url"];
      queries = data ["queries"];
      required = data ["queries" "required"];
      searchInformation = data ["searchInformation"];
    };
    fixConfig = {};
  }
