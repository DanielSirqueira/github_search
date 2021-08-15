import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/extenal/datasources/github_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';
import 'github_datasource_test.mocks.dart';

@GenerateMocks([],
    customMocks: [MockSpec<Dio>(as: #MockDio, returnNullOnMissingStub: true)])
main() {
  final dio = MockDio();
  final datasource = GithubDatasource(dio);

  test("deve retorna uma lista de ResultSearchModel", () async {
    when(dio.get("https://api.github.com/search/users?q=daniel")).thenAnswer(
        (_) async => Response(
            data: jsonDecode(githubResult),
            statusCode: 200,
            requestOptions: RequestOptions(path: '')));

    final future = datasource.getSearch("daniel");
    expect(future, completes);
  });

  test("deve retorna um DatasourceError se o codigo não for 200", () async {
    when(dio.get("https://api.github.com/search/users?q=daniel")).thenAnswer(
        (_) async => Response(
            data: null,
            statusCode: 401,
            requestOptions: RequestOptions(path: '')));

    final future = datasource.getSearch("daniel");
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test("deve retorna um Exception se tiver um erro no dio", () async {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.getSearch("daniel");
    expect(future, throwsA(isA<Exception>()));
  });
}
