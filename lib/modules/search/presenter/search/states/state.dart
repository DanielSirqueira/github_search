import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';

abstract class SearchState {}

class SearchStart implements SearchState {}

class SearchLoading implements SearchState {}

class SearchSuccess implements SearchState {
  final List<ResultSearch> list;

  SearchSuccess(this.list);
}

class SearchError implements SearchState {
  final FailureSearch error;

  SearchError(this.error);
}
