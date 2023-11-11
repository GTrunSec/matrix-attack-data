{ inputs, cell }:
let
  inherit (inputs) std self nixpkgs;
  inherit (inputs.cells.common.lib) l;

  genAttrs = l.listToAttrs (
    map
      (
        attr:
        let
          type = l.replaceStrings [ "-" ] [ "." ] attr;
        in
        {
          name = "${attr}-api";
          value = {
            tags = [
              "schema"
              "json"
            ];
            steps = [
              {
                command = "-N import -s ${cell.schemas."${attr}-api"} -t ${type}.api json";
                transformation = "jq -ec '.[]' ./data/API/${attr}-api.json";
              }
              { command = ''-N export json '#type == "${type}.api"' ''; }
            ];
          };
        }
      )
      [
        "google-search"
        "google-phishing"
      ]
  );
in
genAttrs
