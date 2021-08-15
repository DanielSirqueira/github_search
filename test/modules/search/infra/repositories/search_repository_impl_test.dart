import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/infra/datasources/search_datasource.dart';
import 'package:github_search/modules/search/infra/models/result_search_model.dart';
import 'package:github_search/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_repository_impl_test.mocks.dart';

@GenerateMocks([SearchDatasource])
main() {
  final dataSource = MockSearchDatasource();
  final repository = SearchRepositoryImpl(dataSource);

  test('deve retornar uma lista de ResultSearch', () async {
    when(dataSource.getSearch("daniel"))
        .thenAnswer((_) async => <ResultSearchModel>[]);
    final result = await repository.search("daniel");

    expect(result | [], isA<List<ResultSearch>>());
  });

  test('deve retornar um DatasourceError se o datasource falhar', () async {
    when(dataSource.getSearch("daniel")).thenThrow(Exception());
    final result = await repository.search("daniel");

    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
