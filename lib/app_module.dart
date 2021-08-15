import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search/modules/search/extenal/datasources/github_datasource.dart';
import 'package:github_search/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/search_page.dart';

class AppModule extends Module {
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => GithubDatasource(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchBloc(i())),
      ];

  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => SearchPage()),
      ];
}
