{
  inputs = {
    vast2nix.url = "github:gtrunsec/vast2nix";
  };
  outputs = {self, ...} @ inputs: {
    inherit inputs;
  };
}
