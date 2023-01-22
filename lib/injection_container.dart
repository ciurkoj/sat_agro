import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:satagro/features/sat_agro/data/data_sources/field_local_data_source.dart';
import 'package:satagro/features/sat_agro/data/data_sources/field_remote_data_source.dart';
import 'package:satagro/features/sat_agro/data/repositories/field_repository_impl.dart';
import 'package:satagro/features/sat_agro/domain/repositories/field_repository.dart';
import 'package:satagro/features/sat_agro/domain/usecases/get_field.dart';

import 'package:satagro/features/sat_agro/presentation/bloc/sat_agro_bloc.dart';

import 'core/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - NumberTrivia
  sl.registerFactory(() => SatAgroBloc(getField: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetField(sl()));

  // Repository
  sl.registerLazySingleton<FieldRepository>(() => FieldRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<FieldRemoteDataSource>(() => FieldRemoteDataSourceImpl());
  sl.registerLazySingleton<FieldLocalDataSource>(() => FieldLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
