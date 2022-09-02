{
  inputs,
  cell,
}: {
  kind = "string";
  url = {
    type = "string";
    template = "string";
  };
  queries = {
    required = [
      {
        title = "string";
        searchTerms = "string";
        count = "string";
        startIndex = "string";
        inputEncoding = "string";
        outputEncoding = "string";
        safe = "string";
        cx = "string";
      }
    ];
  };
  searchInformation = {
    searchTime = "count";
    formattedSearchTime = "string";
    totalResults = "string";
    formattedTotalResults = "string";
  };
}
