import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';
import 'package:github_search/modules/search/domain/repositories/search_repository.dart';
import 'package:github_search/modules/search/infra/datasources/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource dataSource;

  SearchRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await dataSource.getSearch(searchText);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
