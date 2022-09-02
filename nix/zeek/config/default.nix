{
  inputs,
  cell,
} @ args: let
in {
  conn = import ./conn.nix args;
  smtp = import ./smtp.nix args;
}
