import 'package:dartz/dartz.dart';
import "package:flutter_test/flutter_test.dart";
import 'package:resocoder_trivia/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test('should return an integer when the string represents an unsigned integer', () {
      //arrange
      final str = '123';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Right(123));
    });

    test('should return a failure when the string is not a integer', () {
      //arrange
      final String str = 'abc';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return a failure when the string is a negative integer', () {
      //assert
      final String str = '-123';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}