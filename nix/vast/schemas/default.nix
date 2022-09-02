{
  inputs,
  cell,
}@args : {
  google-index-api = import ./google-index-api.nix args;
  zeek-conn = import ./zeek-conn.nix args;
}
