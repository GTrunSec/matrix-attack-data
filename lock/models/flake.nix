{
  description = "Attack Modeles Collection";
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
  outputs = {self, ...}: {
  };
}
