{ inputs, cell }:
let
  inherit (inputs.cells.common.lib) __inputs__ l;
  inherit (__inputs__.vast2nix.schemas) lib;
  data =
    v:
    cell.lib.mapAttrsToString (
      l.getAttrFromPath v (inputs.cells.google.config.search-api)
    );
in
lib.writeVastSchema "google-search-api.schema" {
  config = {
    "google.search.api" = data [ ];
    url = data [ "url" ];
    queries = data [ "queries" ];
    required = data [
      "queries"
      "required"
    ];
    searchInformation = data [ "searchInformation" ];
  };
  fixConfig = {
    ## add your aliases here
    "inurl.google.search.api" = "google.search.api";
    "intext.google.search.api" = "google.search.api";
  };
}
