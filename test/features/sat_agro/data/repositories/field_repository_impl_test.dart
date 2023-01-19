import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:satagro/core/error/exceptions.dart';
import 'package:satagro/core/error/failure.dart';
import 'package:satagro/core/network/network_info.dart';
import 'package:satagro/features/sat_agro/data/data_sources/field_local_data_source.dart';
import 'package:satagro/features/sat_agro/data/data_sources/field_remote_data_source.dart';
import 'package:satagro/features/sat_agro/data/data_transfer_objects/field_DTO.dart';
import 'package:satagro/features/sat_agro/data/repositories/field_repository_impl.dart';
import 'package:satagro/features/sat_agro/domain/entities/field.dart';

import 'field_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo])
@GenerateMocks([
  FieldRemoteDataSource,
  FieldLocalDataSource
], customMocks: [
  MockSpec<FieldRemoteDataSource>(as: #MockRemoteDataSource, onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FieldLocalDataSource>(as: #MockLocalDataSource, onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late FieldRepositoryImpl repositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = FieldRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getConcreteField', () {
    const tFieldId = 1234;
    FieldDTO tFieldModel = FieldDTO(id: tFieldId, user: 1234, name: 'Dawna Pogłąć', geom: '16 53');
    Field tField = tFieldModel;

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repositoryImpl.getField(tFieldId);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.getField(any)).thenAnswer((_) async => tFieldModel);
        //act
        final result = await repositoryImpl.getField(tFieldId);
        var foldedResult= result?.fold((failure) => failure, (result) => result);
        //assert
        verify(mockRemoteDataSource.getField(tFieldId));
        expect(foldedResult, equals(tField));
      });
      test('should cache the data locally when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.getField(any)).thenAnswer((_) async => tFieldModel);
        //act
        await repositoryImpl.getField(tFieldId);
        //assert
        verify(mockRemoteDataSource.getField(tFieldId));
        verify(mockLocalDataSource.cacheField(tFieldModel));
      });
      test('should return serverfailure when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.getField(any)).thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getField(tFieldId);
        //assert
        verify(mockRemoteDataSource.getField(tFieldId));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('should return last locally cached data when the cached data is present', () async {
        //arrange
        when(mockLocalDataSource.getLastField()).thenAnswer((_) async => tFieldModel);
        //act
        final result = await repositoryImpl.getField(tFieldId);
        var foldedResult= result?.fold((failure) => failure, (result) => result);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastField());
        expect(foldedResult, equals(tField));
      });
      test('should return CacheFailure when there is no cached data present', () async {
        //arrange
        when(mockLocalDataSource.getLastField()).thenThrow(CacheException());
        //act
        final result = await repositoryImpl.getField(tFieldId);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastField());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
