class Searchevent {}

class SearchProductEvent extends Searchevent {
  final String keyword;
  SearchProductEvent({required this.keyword});
}
