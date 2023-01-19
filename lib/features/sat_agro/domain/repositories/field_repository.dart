import 'package:dartz/dartz.dart';
import 'package:satagro/core/error/failure.dart';
import 'package:satagro/features/sat_agro/domain/entities/field.dart';

abstract class FieldRepository {
  Future<Either<Failure, Field>>? getField(int id);
}
