{
  inputs,
  cell,
}: let
  inherit (inputs) std self nixpkgs;
  data = (std.incl self [(self + /data/zeek)]) + "/data/zeek";
in {
  /*
  zeek conn
  */
  zeek-conn = {
    tags = ["schema" "zeek"];
    steps = [
      {
        command = "-N import -s ${cell.schemas.zeek-conn} -t zeek.conn zeek";
        input = "${data}/conn.log";
      }
      {
        command = ''-N export ascii '#type == "zeek.conn"' '';
      }
    ];
  };
}
