{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-lock.follows = "nixpkgs";

    cells-lab.url = "github:GTrunSec/cells-lab";
    std.follows = "cells-lab/std";
  };
  outputs = {std, ...} @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./nix;

      cellBlocks = [
        (std.blockTypes.installables "packages")

        (std.blockTypes.functions "devshellProfiles")
        (std.blockTypes.devshells "devshells")

        (std.blockTypes.runnables "entrypoints")

        (std.blockTypes.functions "lib")

        (std.blockTypes.functions "packages")

        (std.blockTypes.data "config")

        (std.blockTypes.data "jsonschemas")

        (std.blockTypes.files "schemas")

        (std.blockTypes.nixago "nixago")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["_automation" "devshells"];
    };
}
