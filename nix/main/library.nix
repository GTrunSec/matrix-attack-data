{
  inputs,
  cell,
} @ args': let
  inherit (inputs.cells-lab.main.library) callFlake;
  inherit (inputs) std self nixpkgs;
  l = nixpkgs.lib // builtins // __inputs__.POP.lib;

  __inputs__ = callFlake "${(std.incl self [(self + /lock/default)])}/lock/default" {
    nixpkgs.locked = inputs.nixpkgs-lock.sourceInfo;
    # add channel follows
    POP.nixpkgs.follows = "nixpkgs";
  };

  __inputs_models__ = callFlake "${(std.incl self [(self + /lock/models)])}/lock/models" {
    nixpkgs.locked = inputs.nixpkgs-lock.sourceInfo;
  };
in {
  inherit __inputs__ __inputs_models__ l;
}
