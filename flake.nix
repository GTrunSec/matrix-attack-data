{
  inputs = {
    nixpkgs.follows = "std-ext/nixpkgs";
    std-ext.url = "github:GTrunSec/std-ext";
    std.follows = "std-ext/std";
    flops.follows = "std-ext/flops";
  };
  outputs =
    { std, ... }@inputs:
    std.growOn
      {
        inherit inputs;
        cellsFrom = ./nix;

        cellBlocks = with std.blockTypes; [
          (installables "packages")

          (functions "shellsProfiles")
          (devshells "shells")

          (runnables "entrypoints")
          (runnables "scripts")
          (runnables "tasks")

          (functions "lib")

          (functions "packages")

          (data "config")
          (files "configFiles")

          (data "jsonschemas")

          (files "schemas")

          (nixago "nixago")
        ];
      }
      {
        devShells = inputs.std.harvest inputs.self [
          "dev"
          "shells"
        ];
      };
}
