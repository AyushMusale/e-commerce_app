import 'package:ecapp/data/models/searchlist.dart';

class SearchState {
  final Searchlist searchlist;
  final bool isLoading;
  final String? message;
  final bool? error;

  SearchState({
    required this.searchlist,
    this.isLoading = false,
    this.message,
    this.error,
  });

  SearchState copyWith({
    Searchlist? searchlist,
    bool? isLoading,
    String? message,
    bool? error,
  }) {
    return SearchState(
      searchlist: searchlist ?? this.searchlist,
      isLoading: isLoading ?? this.isLoading,
      message: message,
      error: error ?? false,
    );
  }
}

class SearchInititalState extends SearchState {
  SearchInititalState() : super(searchlist: Searchlist(product: []));
}
