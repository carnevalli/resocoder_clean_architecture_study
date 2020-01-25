import 'dart:convert';
import 'dart:io';

import 'package:resocoder_trivia/core/error/exception.dart';
import 'package:resocoder_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import "package:http/http.dart" as http;
import "package:meta/meta.dart";

abstract class NumberTriviaRemoteDataSource {

  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl extends NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) => _getTriviaFromUrl("http://numbersapi.com/$number");

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() => _getTriviaFromUrl("http://numbersapi.com/random");

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(url, headers: {'Content-Type' : 'application/json'});

    if(response.statusCode == HttpStatus.ok)
      return NumberTriviaModel.fromJson(json.decode(response.body));
    throw ServerException();
  }
}