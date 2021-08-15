import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchByText])
main() {
  final usecase = MockSearchByText();
  final bloc = SearchBloc(usecase);

  test('Deve retornar os estados na ordem correta', () {
    when(usecase.call('daniel'))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    expectLater(
        bloc.stream,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSuccess>(),
        ]));
    bloc.add('daniel');
  });

  test('Deve retornar error', () {
    when(usecase.call('daniel'))
        .thenAnswer((_) async => Left(InvalidTextError()));

    expectLater(
        bloc.stream,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchError>(),
        ]));
    bloc.add('daniel');
  });
}
