import 'package:dartz/dartz.dart';
import 'package:resocoder_trivia/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try{
      final int v = int.parse(str);
      if(v < 0) {
        return Left(InvalidInputFailure());
      }
      return Right(v);
    }on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}