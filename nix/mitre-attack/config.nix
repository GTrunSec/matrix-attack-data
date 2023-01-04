{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (__inputs__) attack-control-framework-mappings attack-flow;

  l = inputs.nixpkgs.lib // builtins;
  nist800_53_r4-controls' = l.fromJSON (l.readFile (attack-control-framework-mappings + "/frameworks/attack_10_1/nist800_53_r4/stix/nist800-53-r4-controls.json"));
in {
  nist800_53_r4-controls = l.foldl' l.recursiveUpdate {} (map (v: { "${v.id}" = v;}) nist800_53_r4-controls'.objects);
}
