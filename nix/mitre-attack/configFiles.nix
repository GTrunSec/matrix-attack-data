{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeShellApplication writeConfig;
in {
  nist800_53_r4-controls = writeConfig "nist800_53_r4-controls.yaml" cell.config.nist800_53_r4-controls;
}
