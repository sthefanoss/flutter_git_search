enum SearchType { open, filtered }

class Search {
  final String input;
  final int pageIndex;
  final int sinceIndex;
  final SearchType type;

  const Search.filtered({
    this.input,
    this.pageIndex,
  })  : type = SearchType.filtered,
        sinceIndex = null;

  const Search.open({this.sinceIndex})
      : type = SearchType.open,
        input = null,
        pageIndex = null;
}
