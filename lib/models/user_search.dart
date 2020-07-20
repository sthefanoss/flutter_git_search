enum UserSearchType { all, filtered }

class UserSearch {
  const UserSearch({
    this.isNewSearch,
    this.searchText,
    this.pageIndex,
    this.totalCount,
    this.sinceIndex,
    this.type,
  });

  final bool isNewSearch;
  final String searchText;
  final int pageIndex;
  final int totalCount;
  final int sinceIndex;
  final UserSearchType type;
}
