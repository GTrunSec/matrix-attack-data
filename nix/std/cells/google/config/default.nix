{ inputs, cell }@args:
{
  search-api = import ./google-search-api.nix args;
  phishing-api = import ./google-phishing-api.nix args;
}
