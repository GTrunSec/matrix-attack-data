{
  inputs = {
    nixpkgs.follows = "cells-lab/nixpkgs";
    cells-lab.url = "github:GTrunSec/cells-lab";
    std.follows = "cells-lab/std";
  };
  outputs = {std, ...} @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./nix;

      cellBlocks = with std.blockTypes; [
        (installables "packages")

        (functions "devshellProfiles")
        (devshells "devshells")

        (runnables "entrypoints")

        (functions "lib")

        (functions "packages")

        (data "config")

        (data "jsonschemas")

        (files "schemas")

        (nixago "nixago")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["automation" "devshells"];
    };
}
