{
  inputs = {
    vast2nix.url = "github:gtrunsec/vast2nix";

    POP.url = "github:divnix/POP/visibility";
    structurizr2nix.url = "github:GTrunSec/structurizr2nix";
  };
  outputs = {self, ...} @ inputs: {
    inherit inputs;
  };
}
