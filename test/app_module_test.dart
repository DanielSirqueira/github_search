import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app_module.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';

main() {
  Modular.init(AppModule());

  test('Deve recuperar o usercase sem erro', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test('Deve trazer uma lista de ResultSearch', () async {
    final usecase = Modular.get<SearchByText>();
    final result = await usecase("daniel");

    expect(result | [], isA<List<ResultSearch>>());
  });
}
