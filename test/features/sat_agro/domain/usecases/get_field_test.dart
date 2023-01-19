import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:satagro/core/usecases/use_case.dart';
import 'package:satagro/features/sat_agro/domain/entities/field.dart';
import 'package:satagro/features/sat_agro/domain/repositories/field_repository.dart';
import 'package:satagro/features/sat_agro/domain/usecases/get_field.dart';

import 'get_field_test.mocks.dart';

@GenerateMocks([FieldRepository])
void main() {
  late MockFieldRepository mockNumberTriviaRepository;
  late GetField usecase;
  late int id;
  late Field tField;
  late Params tParams;

  setUp(() {
    mockNumberTriviaRepository = MockFieldRepository();
    usecase = GetField(mockNumberTriviaRepository);
    tField = Field(id: 9999, user: 1234, name: 'Dawna Pogłąć', geom: '16 53');
    id = 1234;
    tParams = Params(id: 1234 );
  });

  test(
    'should get field for the id from the repository',
    () async {
      //arange

      when(mockNumberTriviaRepository.getField(id)).thenAnswer((e) async {
        return Right(tField);
      });
      //act
      final result = await usecase(Params(id: id));
      var foldedResult= result?.fold((failure) => failure, (result) => result);
      //assert
      expect(foldedResult,  equals(tField));
      verify(mockNumberTriviaRepository.getField(id));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );

  group('Params() test', () {
    test(
      'should return a valid props',
      () async {
        expect(tParams.props, [1234]);
      },
    );

    test(
      'should return a valid Id',
      () async {
        expect(tParams.getId, 1234);
      },
    );
  });
}
