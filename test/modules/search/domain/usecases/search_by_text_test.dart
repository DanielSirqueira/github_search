import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/repositories/search_repository.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_by_text_test.mocks.dart';

@GenerateMocks([SearchRepository])
main() {
  final repository = MockSearchRepository();

  final usecase = SearchByTextImpl(repository);

  test('Deve retornar uma lista de ResultSearch', () async {
    when(repository.search('daniel'))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    final result = await usecase('daniel');
    expect(result | [], isA<List<ResultSearch>>());
  });

  test('Deve retornar um InvalidTextError caso o texto seja invalido',
      () async {
    when(repository.search(''))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    final result = await usecase('');
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
