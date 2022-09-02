{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  tests = {
    /*
    Google search search API
    */
    google-search-api = {
      tags = ["schema" "json"];
      steps = [
        {
          command = "-N import -s ${cell.schemas.google-search-api} -t google.search.api json";
          transformation = "jq -ec '.[1]' ./data/google-search-api.json";
        }
        {
          command = ''-N export json '#type == "google.search.api"' '';
        }
      ];
    };

    /*
    Google phishing search API
    */

    google-phishing-api = {
      tags = ["schema" "json"];
      steps = [
        {
          command = "-N import -s ${cell.schemas.google-phishing-api} -t google.phishing.api json";
          transformation = "jq -ec '.[0]' ./data/google-phishing-api.json";
        }
        {
          command = ''-N export json '#type == "google.phishing.api"' '';
        }
      ];
    };
  };
}
