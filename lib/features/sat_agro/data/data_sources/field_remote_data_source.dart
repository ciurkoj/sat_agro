import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:satagro/features/sat_agro/data/data_transfer_objects/field_DTO.dart';

abstract class FieldRemoteDataSource {
  Future<FieldDTO> getField(int id);
}

class FieldRemoteDataSourceImpl implements FieldRemoteDataSource {
  FieldRemoteDataSourceImpl();

  @override
  Future<FieldDTO> getField(int id) async {
    // work in progress, id to be used
    var field = File('fixtures/field.json').readAsStringSync();
    return FieldDTO.fromJson(jsonDecode(field));
  }
}
