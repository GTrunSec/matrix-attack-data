{ inputs, cell }:
let
  inherit (inputs.cells.common.lib) __inputs__;
in
{
  nist_controls = __inputs__.diagram2nix.plantuml.lib.json2plantuml {
    name = "nist_controls";
    config = cell.config.nist_controls;
  };
}
