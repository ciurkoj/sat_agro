import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:satagro/features/sat_agro/presentation/bloc/sat_agro_bloc.dart';

void main() {
  late LoadField tLoadField;
  late ChangeMap tChangeMap;


  setUp(() {
    tChangeMap = ChangeMap(MapType.terrain);
    tLoadField = LoadField();
  });

  group('NoParams() test', () {
    test(
      'should return a valid invoiceId',
          () async {
        expect(tChangeMap.mapType, MapType.terrain);
      },
    );

    test('',
          () async {
        expect(tLoadField.props, []);
      },
    );
  });
}
