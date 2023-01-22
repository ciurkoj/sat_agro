import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:satagro/features/sat_agro/data/data_transfer_objects/field_DTO.dart';

abstract class FieldRemoteDataSource {
  Future<FieldDTO>? getField(int id);
}

class FieldRemoteDataSourceImpl implements FieldRemoteDataSource {
  FieldRemoteDataSourceImpl();

  @override
  Future<FieldDTO>? getField(int id) async {
    // work in progress, id to be used if correct data is proivded
    final data = await json.decode(await rootBundle.loadString('assets/field.json'));
    return FieldDTO.fromJson(data);
  }
}
