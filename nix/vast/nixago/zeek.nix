{
  inputs,
  cell,
}: let
  inherit (inputs) std self nixpkgs;
  inherit (inputs.cells.main.library) l;
  data = (std.incl self [(self + /data/zeek)]) + "/data/zeek";

  genAttrs = l.listToAttrs (map (attr: {
    name = "zeek-${attr}";
    value = {
      tags = ["schema" "zeek"];
      steps = [
        {
          command = "-N import -s ${cell.schemas."zeek-${attr}"} -t zeek.${attr} zeek";
          input = "${data}/${attr}.log";
        }
        {
          command = ''-N export ascii '#type == "zeek.${attr}"' '';
        }
      ];
    };
  }) ["conn" "smtp"]);
in {
  /*
  zeek conn
  */
  inherit (genAttrs) zeek-conn zeek-smtp;
}
