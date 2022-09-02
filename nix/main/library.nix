{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.main.library) callFlake;
  inherit (inputs) std self;
  __inputs__ = callFlake "${(std.incl self [(self + /lock)])}/lock" {
    nixpkgs.locked = inputs.nixpkgs-lock.sourceInfo;
  };
in {
  inherit __inputs__;
}
