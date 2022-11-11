{
  inputs,
  cell,
}: let
  inherit (inputs) std self nixpkgs;
  inherit (inputs.cells.common.lib) l;
  data = (std.incl self [(self + /data/zeek)]) + "/data/zeek";

  genAttrs = l.listToAttrs (map (attr: {
    name = "zeek-${attr}";
    value = {
      tags = ["schema" "zeek" "${attr}"];
      steps = [
        {
          command = "-N import -s ${cell.schemas."zeek-${attr}"} -t zeek.${attr} zeek";
          input = "${data}/${attr}.log";
        }
        {
          command = ''-N export json '#type == "zeek.${attr}"' '';
        }
      ];
    };
  }) ["conn" "smtp" "pop3" "imap"]);
in
  genAttrs
