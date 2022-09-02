{
  inputs,
  cell,
} @ args: {
  conn = import ./conn.nix args;
  smtp = import ./smtp.nix args;
}
