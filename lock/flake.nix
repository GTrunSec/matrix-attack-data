{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/f21f11aa2a02cb78651c6d57546c7d7541f9240c";
    vast2nix.url = "github:gtrunsec/vast2nix";
    vast2nix.inputs.nixpkgs.follows = "nixpkgs";

    POP.url = "github:divnix/POP/visibility";
    diagram2nix.url = "github:GTrunSec/diagram2nix";
  };

  # description = "Collection of attack frameworks and resources";
  inputs = {
    attack-control-framework-mappings = {
      url = "github:center-for-threat-informed-defense/attack-control-framework-mappings";
      flake = false;
    };

    attack-flow = {
      url = "github:center-for-threat-informed-defense/attack-flow";
      flake = false;
    };
  };

  # description = "Cybersecurity Schema Framework";
  inputs = {
    ocsf.url = "github:ocsf/ocsf-schema";
    ocsf.flake = false;
  };

  outputs = {self, ...} @ inputs: {
    inherit inputs;
  };
}
