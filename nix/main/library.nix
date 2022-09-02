{
  inputs,
  cell,
} @ args': let
  inherit (inputs.cells-lab.main.library) callFlake;
  inherit (inputs) std self nixpkgs;
  l = nixpkgs.lib // builtins // __inputs__.POP.lib;

  __inputs__ = callFlake "${(std.incl self [(self + /lock)])}/lock" {
    nixpkgs.locked = inputs.nixpkgs-lock.sourceInfo;
    # add channel follows
    POP.nixpkgs.follows = "nixpkgs";
  };
in {
  inherit __inputs__ l;
}
