import "dart:convert";
import "dart:io";

import "package:flutter_test/flutter_test.dart";
import "package:satagro/features/sat_agro/data/data_transfer_objects/field_DTO.dart";

void main() {
  final tFieldModel = FieldDTO(id: 9999, user: 123, name: 'Dawna Pogłąć', geom: '16 53');

  test(
    'should be a subclass of FieldDTO entity ',
    () async {
      // assert
      expect(tFieldModel, isA<FieldDTO>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the id number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(File('test/fixtures/field.json').readAsStringSync());
        // act
        final result = FieldDTO.fromJson(jsonMap);
        // assert
        expect(result.id, tFieldModel.id);
      },
    );

    test(
      'should return a valid model when the name is a string',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(File('test/fixtures/field.json').readAsStringSync());
        // act
        final result = FieldDTO.fromJson(jsonMap);
        // assert
        expect(result.name, tFieldModel.name);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a valid json map containing the proper data',
      () async {
        // act
        final result = FieldDTO(id: 9999, user: 123, name: "Dawna Pogłąć", geom: '16 53').toJson();
        // assert
        final expectedMap = {
          'id': 9999,
          'user': 123,
          'name': 'Dawna Pogłąć',
          'geom': '16 53',
        };
        expect(result, expectedMap);
      },
    );
  });
}
