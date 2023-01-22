import 'package:dartz/dartz.dart';
import 'package:satagro/core/error/exceptions.dart';
import 'package:satagro/core/error/failure.dart';
import 'package:satagro/core/network/network_info.dart';
import 'package:satagro/features/sat_agro/data/data_sources/field_local_data_source.dart';
import 'package:satagro/features/sat_agro/data/data_sources/field_remote_data_source.dart';
import 'package:satagro/features/sat_agro/data/data_transfer_objects/field_DTO.dart';
import 'package:satagro/features/sat_agro/domain/entities/field.dart';
import 'package:satagro/features/sat_agro/domain/repositories/field_repository.dart';

class FieldRepositoryImpl implements FieldRepository {
  late final FieldRemoteDataSource remoteDataSource;
  late final FieldLocalDataSource localDataSource;
  late final NetworkInfo networkInfo;

  FieldRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Field>>? getField(int id) async {
    return await _getField(() {
      return remoteDataSource.getField(id)!;
    });

  }
  
  Future<Either<Failure, Field>> _getField(
      _FieldFromRemoteOrCache getFieldFromRemoteOrCache) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteField = await getFieldFromRemoteOrCache();
        localDataSource.cacheField(remoteField);
        return Right(remoteField);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final Field localField = await localDataSource.getLastField() ;
        return Right(localField);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

typedef _FieldFromRemoteOrCache = Future<FieldDTO> Function();

