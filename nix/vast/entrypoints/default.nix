{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab._writers.library) writeShellApplication;
  inherit (inputs) nixpkgs;
  inherit (inputs.cells.main.library.__inputs__) vast2nix;
in {
  check = writeShellApplication {
    name = "check-vast-data";
    runtimeInputs = [vast2nix.packages.${nixpkgs.system}.vast-integration vast2nix.packages.${nixpkgs.system}.vast-bin nixpkgs.jq];
    text = ''
      # shellcheck disable=all
      if [[ ! -z "$@" ]]; then
         vast-integration -s ${cell.nixago.vast-integation.configFile} -t "$@" || true
      else
        vast-integration -s ${cell.nixago.vast-integation.configFile} || true
      fi
      rm -rf run_*
    '';
  };
}
