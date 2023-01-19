import 'dart:async';
import 'dart:convert';

import 'package:satagro/core/error/exceptions.dart';
import 'package:satagro/features/sat_agro/data/data_transfer_objects/field_DTO.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FieldLocalDataSource {
  /// Gets the cached [FieldObject] which was gotten the last time
  /// user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<FieldDTO> getLastField();

  Future<void>? cacheField(FieldDTO fieldDTO);
}

// ignore: constant_identifier_names
const CACHED_LAST_FIELD = 'CACHED_LAST_FIELD';

class FieldLocalDataSourceImpl implements FieldLocalDataSource {
  final SharedPreferences sharedPreferences;

  FieldLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheField(FieldDTO fieldModelToCache) {
    return sharedPreferences.setString(
        CACHED_LAST_FIELD, json.encode(fieldModelToCache.toJson()));
  }

  @override
  Future<FieldDTO> getLastField() {
    final jsonString = sharedPreferences.getString(CACHED_LAST_FIELD);
    if (jsonString != null) {
      return Future.value(FieldDTO.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
