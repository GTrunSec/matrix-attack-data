{
  inputs,
  cell,
} @ args: {
  conn = import ./conn.nix args;
  smtp = import ./smtp.nix args;
  pop3 = import ./pop3.nix args;
}
