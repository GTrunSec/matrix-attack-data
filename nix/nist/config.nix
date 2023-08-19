{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells.common.lib) __inputs__;

  l = nixpkgs.lib // builtins;

  __nist_controls__ =
    let
      source = nixpkgs.fetchurl {
        url = "https://swimlane-pyattck.s3.us-west-2.amazonaws.com/merged_nist_controls_v1.json";
        sha256 = "sha256-gBQOFWLH2iT2C78wJ9384oLCkmGGHmZV/ZgTSXm5Huo=";
      };
    in
    l.fromJSON (l.readFile source);
  nist800_53_r4-controls' = l.fromJSON (
    l.readFile (
      __inputs__.attack-control-framework-mappings
      + "/frameworks/attack_10_1/nist800_53_r4/stix/nist800-53-r4-controls.json"
    )
  );
in
{
  nist800_53_r4-controls = l.foldl' l.recursiveUpdate { } (
    map (v: { "${v.id}" = v; }) nist800_53_r4-controls'.objects
  );
  nist_controls = l.foldl' l.recursiveUpdate { } (
    map (v: { "${v.id}" = v; }) __nist_controls__.objects
  );
}
