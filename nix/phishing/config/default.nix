{
  inputs,
  cell,
} @ args: let
  l = inputs.nixpkgs.lib // builtins;
in {
  phishing-features = import ./phishing-features.nix args;

  phishing-url-result = l.removeAttrs ((builtins.mapAttrs (n: v: v.schemas.result.example) cell.config.phishing-features)
    // {
      google_search_api_index = 0;
      google_search_api_links_pointing_to_page = 0;
    }) ["google_search_api"];

  phishing-url-data =
    builtins.mapAttrs (n: v: v.schemas.data.example) (cell.config.phishing-features);
}
