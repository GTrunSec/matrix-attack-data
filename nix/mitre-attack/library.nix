{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs_models__;
  inherit (__inputs_models__) attack-control-framework-mappings attack-flow;
in {
}
