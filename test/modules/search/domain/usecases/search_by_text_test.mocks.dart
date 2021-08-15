// Mocks generated by Mockito 5.0.14 from annotations
// in github_search/test/modules/search/domain/usecases/search_by_text_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:github_search/modules/search/domain/entities/result_search.dart'
    as _i6;
import 'package:github_search/modules/search/domain/errors/errors.dart' as _i5;
import 'package:github_search/modules/search/domain/repositories/search_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [SearchRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchRepository extends _i1.Mock implements _i3.SearchRepository {
  MockSearchRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.FailureSearch, List<_i6.ResultSearch>>> search(
          String? searchText) =>
      (super.noSuchMethod(Invocation.method(#search, [searchText]),
              returnValue: Future<
                      _i2.Either<_i5.FailureSearch,
                          List<_i6.ResultSearch>>>.value(
                  _FakeEither_0<_i5.FailureSearch, List<_i6.ResultSearch>>()))
          as _i4.Future<_i2.Either<_i5.FailureSearch, List<_i6.ResultSearch>>>);
  @override
  String toString() => super.toString();
}
