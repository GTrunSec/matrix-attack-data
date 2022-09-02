{
  inputs = {
    vast2nix.url = "github:gtrunsec/vast2nix";

    POP.url = "github:divnix/POP/visibility";
  };
  outputs = {self, ...} @ inputs: {
    inherit inputs;
  };
}
