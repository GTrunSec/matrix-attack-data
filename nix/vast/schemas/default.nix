{
  inputs,
  cell,
} @ args: {
  google-search-api = import ./google-search-api.nix args;
  google-phishing-api = import ./google-phishing-api.nix args;

  zeek-conn = import ./zeek-conn.nix args;
  zeek-smtp = import ./zeek-smtp.nix args;
  zeek-pop3 = import ./zeek-pop3.nix args;
}
