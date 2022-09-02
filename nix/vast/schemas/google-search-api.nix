{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) library;
  data = v: cell.library.mapAttrsToString (l.getAttrFromPath v (inputs.cells.google.config.search-api));
in
  library.writeVastSchema "google-search-api.schema" {
    config = {
      "google.search.api" = data [];
      url = data ["url"];
      queries = data ["queries"];
      required = data ["queries" "required"];
      searchInformation = data ["searchInformation"];
    };
    fixConfig = {};
  }
