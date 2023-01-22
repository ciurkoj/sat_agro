import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:satagro/core/error/failure.dart';
import 'package:satagro/core/usecases/use_case.dart';
import 'package:satagro/features/sat_agro/domain/entities/field.dart';
import 'package:satagro/features/sat_agro/domain/usecases/get_field.dart';
import 'package:satagro/features/sat_agro/presentation/bloc/sat_agro_bloc.dart';

import '../bloc/sat_agro_bloc_test.mocks.dart';

@GenerateMocks([GetField, LoadField])
void main() {
  late SatAgroBloc bloc;
  late MockLoadField mockLoadField;
  late MockGetField mockGetField;


  setUp(() {
    mockGetField = MockGetField();
    mockLoadField = MockLoadField();


    bloc = SatAgroBloc(getField: mockGetField);
  });
  final tField = Field(id: 1,user:1, name:"name",geom:"1",area: 2.0);

  test(
    'initialState should be SatAgroInitial',
    () async {
      // assert
      expect(bloc.initialState, equals(SatAgroInitial()));
    },
  );

  group('GetField', () {

    test('should get data from the concrete usecase', () async* {
      //arrange
      when(mockGetField(const Params(id:1))).thenAnswer((_) async =>  Right(tField));
      //act
      bloc.add(mockLoadField);
      await untilCalled(mockGetField(any));

      //assert
      verify(mockGetField(any));
    });

    test('should emits [Loading, Loaded] when data is gotten successfully', () async* {
      //arrange
      when(mockGetField(any)).thenAnswer((_) async =>  Right(tField));

      //assert later
      final expected = [
        SatAgroInitial(),
        Loading(),
         Loaded(field: tField, points: [], holes:[])
      ];
      expectLater(bloc, emitsInOrder(expected));

      //act
      bloc.add(mockLoadField);
    });

    test('should emits [Loading, Error] when getting data fails', () async* {
      //arrange
      when(mockGetField(any)).thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      final expeted = [SatAgroInitial(), Loading(),  const Error(message: SERVER_FAILURE_MESSAGE)];
      expectLater(bloc, emitsInOrder(expeted));
      //act
      bloc.add(mockLoadField);
    });

    test('should emits [Loading, Error] with a proper message for the error when getting data fails', () async* {
      //arrange
      when(mockGetField(any)).thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      final expeted = [SatAgroInitial(), Loading(),  const Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc, emitsInOrder(expeted));
      //act
      bloc.add(mockLoadField);
    });
  });


  group("test helper methods of SatAgroBloc", () {
    test('test eitherLoadedOrErrorState() ', () {
      expect(
        bloc.eitherLoadedOrErrorState(Right(tField)),
        emitsInOrder([
           Loaded(field: tField, points: [],holes: []),
          emitsDone
        ]),
      );
    });

    test(
      'should return a server failure message',
      () {
        // assert
        expect(SERVER_FAILURE_MESSAGE, equals(bloc.mapFailureToMessage(ServerFailure())));
      },
    );
    test(
      'should return a cache failure message',
      () {
        // assert
        expect(CACHE_FAILURE_MESSAGE, equals(bloc.mapFailureToMessage(CacheFailure())));
      },
    );
  });
}
