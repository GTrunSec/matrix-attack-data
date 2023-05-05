{
  inputs,
  cell,
}: let
  inherit (inputs.std-ext.writers.lib) writeShellApplication writeConfig;
in {
  nist800_53_r4-controls = writeConfig "nist800_53_r4-controls.yaml" cell.config.nist800_53_r4-controls;
  queries = writeConfig "queries.json" cell.config.queries;
}
