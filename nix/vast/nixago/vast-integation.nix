{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  tests = {
    google-index-api = {
      tags = ["schema" "json"];
      steps = [
        {
          command = "-N import -s ${cell.schemas.google-index-api} -t google.index.api json";
          transformation = "jq -ec '.[1]' ./data/google-index-api-result.json";
        }
        {
          command = ''-N export json '#type == "google.index.api"' '';
        }
      ];
    };
  };
}
