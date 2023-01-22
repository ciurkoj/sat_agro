// Mocks generated by Mockito 5.3.2 from annotations
// in satagro/test/features/sat_agro/data/datasources/field_remote_data_source_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:satagro/features/sat_agro/data/data_sources/field_remote_data_source.dart'
    as _i2;
import 'package:satagro/features/sat_agro/data/data_transfer_objects/field_DTO.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [FieldRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockFieldRemoteDataSourceImpl extends _i1.Mock
    implements _i2.FieldRemoteDataSourceImpl {
  MockFieldRemoteDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.FieldDTO>? getField(int? id) =>
      (super.noSuchMethod(Invocation.method(
        #getField,
        [id],
      )) as _i3.Future<_i4.FieldDTO>?);
}
