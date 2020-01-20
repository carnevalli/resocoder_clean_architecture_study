import 'package:resocoder_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:resocoder_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import "package:mockito/mockito.dart";
import "package:flutter_test/flutter_test.dart";
import 'package:resocoder_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import "package:dartz/dartz.dart";

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository{

}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'Test');

  test('should get trivia for the number from the repository', () async {
    
    // "On the fly" implementation of Repository using the Mockito package.
    // Wthen getConcreteNumberTrivia is called with any argument, always answer with
    // the Right "side" of Either containing a test NumberTrivia object.
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
      .thenAnswer((answer) async => Right(tNumberTrivia));

    //The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase(number: tNumber);

    // Usecase should simply return whatever was returned from the Repository
    expect(result, Right(tNumberTrivia));

    // Verifiy that the method has been called on the Repository
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));

    // Only the above method should be called and nothing more
    verifyNoMoreInteractions(mockNumberTriviaRepository);
    
  });
}