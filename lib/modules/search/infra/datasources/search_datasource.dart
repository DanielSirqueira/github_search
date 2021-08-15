import 'package:github_search/modules/search/infra/models/result_search_model.dart';

abstract class SearchDatasource {
  Future<List<ResultSearchModel>> getSearch(String searchText);
}
