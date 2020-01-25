import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:resocoder_trivia/core/error/exception.dart';
import 'package:resocoder_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:resocoder_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:matcher/matcher.dart";

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}
  
void main() {
  NumberTriviaLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    test('should return NumberTrivia from SharedPreferences when there is one in the cache', () async {
      final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
      //arrange
      when(mockSharedPreferences.getString(any))
        .thenReturn(fixture('trivia_cached.json'));

      //act
      final result = await dataSource.getLastNumberTrivia();

      //assert
      verify(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a CacheException where there is not a cached value', () async {
      // arrange
      when(mockSharedPreferences.getString(any))
        .thenReturn(null);

      //act
      final call = dataSource.getLastNumberTrivia;

      //assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cache number trivia', () {
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test trivia');

    test('should call SharedPreferences to cache the data', () {
      //act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);

      //assert
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString('CACHED_NUMBER_TRIVIA', expectedJsonString));
    });
  });
}