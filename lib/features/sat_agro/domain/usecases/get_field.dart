import 'package:dartz/dartz.dart';
import 'package:satagro/core/error/failure.dart';
import 'package:satagro/core/usecases/use_case.dart';
import 'package:satagro/features/sat_agro/domain/entities/field.dart';
import 'package:satagro/features/sat_agro/domain/repositories/field_repository.dart';

class GetField extends UseCase<Field, Params> {
  final FieldRepository repository;

  GetField(this.repository);

  @override
  Future<Either<Failure, Field>?> call(Params params) async {
    return await repository.getField(params.id);
  }
}
