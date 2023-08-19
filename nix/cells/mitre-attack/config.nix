{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (__inputs__) attack-control-framework-mappings;

  l = inputs.nixpkgs.lib // builtins;
  __attack-data__ =
    let
      source = nixpkgs.fetchurl {
        url = "https://swimlane-pyattck.s3.us-west-2.amazonaws.com/generated_attck_data.json";
        sha256 = "sha256-WeED8ZtOOq3e3Ydkj41mKyQfiO7JINmoSwbVwqArWMk=";
      };
    in
    l.importJSON ./generated_attck_data.json;
in
{
  inherit __attack-data__;
  attack-data = l.foldl' l.recursiveUpdate { } (
    map (v: { "${v.technique_id}" = v; }) __attack-data__.techniques
  );

  queries =
    let
      filterQeueries = l.filterAttrs (n: v: v.queries != [ ]) cell.config.attack-data;
    in
    l.mapAttrs
      (
        n: v:
        (l.foldl' l.recursiveUpdate { } (map (v': { "${v'.product}" = v'; }) v.queries))
      )
      filterQeueries;
}
