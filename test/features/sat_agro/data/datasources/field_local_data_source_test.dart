import 'dart:convert';
import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satagro/core/error/exceptions.dart';
import 'package:satagro/features/sat_agro/data/data_sources/field_local_data_source.dart';
import 'package:satagro/features/sat_agro/data/data_transfer_objects/crop_history_DTO.dart';
import 'package:satagro/features/sat_agro/data/data_transfer_objects/field_DTO.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'field_local_data_source_test.mocks.dart';



@GenerateMocks([
  SharedPreferences,
  FieldLocalDataSourceImpl
])
void main() {
  late FieldLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  var x = json.decode(File("test/fixtures/field.json").readAsStringSync());
  final tFieldModel = FieldDTO.fromJson(json.decode(File("test/fixtures/field.json").readAsStringSync()));


  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = FieldLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastField', () {
    final tFieldModel = FieldDTO.fromJson(json.decode(File("test/fixtures/field.json").readAsStringSync()));
    test('should return Field from SharedPreferences when there is one in the cache', () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(File("test/fixtures/field.json").readAsStringSync());
      //act
      final result = await dataSource.getLastField();
      //assert
      verify(mockSharedPreferences.getString(CACHED_LAST_FIELD));
      expect(result, equals(tFieldModel));
    });

    test('should throw a CacheException when there is not a cached value', () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = dataSource.getLastField;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });



  group('cacheField', () {
    test('should call SharedPreferences to cache the data', () async {
      //arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      //act
      dataSource.cacheField(tFieldModel);
      //assert
      final expectedJsonString = json.encode(tFieldModel.toJson());
      // mockSharedPreferences.setString(CACHED_LAST_FIELD, expectedJsonString); // incorrect, to be removed
      verify(mockSharedPreferences.setString(CACHED_LAST_FIELD, expectedJsonString)).called(1);
    });
  });
}
