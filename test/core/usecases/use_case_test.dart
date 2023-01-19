import 'package:flutter_test/flutter_test.dart';
import 'package:satagro/core/usecases/use_case.dart';

void main() {
  late Params tParams;
  late NoParams tNoParams;

  setUp(() {
    tParams = const Params(id: 9999);
    tNoParams = NoParams();
  });


  group('Params() test', () {
    test(
      'should return a valid props',
          () async {
        expect(tParams.props, [9999]);
      },
    );

    test(
      'should return a valid is',
          () async {
        expect(tParams.getId, 9999);
      },
    );
  });
  group('NoParams() test', () {
    test(
      'should return an empty list',
          () async {
        expect(tNoParams.props, []);
      },
    );

  });
}
