import 'dart:convert';
import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satagro/features/sat_agro/data/data_sources/field_remote_data_source.dart';
import 'package:satagro/features/sat_agro/data/data_transfer_objects/field_DTO.dart';
import 'field_remote_data_source_test.mocks.dart';

@GenerateMocks([FieldRemoteDataSourceImpl])
void main() {
  late FieldRemoteDataSourceImpl dataSource;

  setUp(() async {
    dataSource = MockFieldRemoteDataSourceImpl();
  });

  group('getConcreteField', () {
    int id = 1234;
    final tFieldModel =
        FieldDTO.fromJson(json.decode(File("test/fixtures/field.json").readAsStringSync()));

    test(
      'should return Field when the response is success',
      () async {
        // arrange
        when(dataSource.getField(id)).thenAnswer((_) => Future.value(tFieldModel));
        // act
        final result = await dataSource.getField(id);
        // assert
        expect(result, equals(tFieldModel));
      },
    );
  });
}
