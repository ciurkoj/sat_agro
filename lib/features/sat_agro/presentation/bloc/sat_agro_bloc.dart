import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:satagro/core/error/failure.dart';
import 'package:satagro/core/usecases/use_case.dart';
import 'package:satagro/features/sat_agro/domain/entities/field.dart';
import 'package:satagro/features/sat_agro/domain/usecases/get_field.dart';

part 'sat_agro_event.dart';

part 'sat_agro_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String AREA_IS_NEGATIVE = 'Area is negative';

class SatAgroBloc extends Bloc<SatAgroEvent, SatAgroState> {
  final GetField getField;

  SatAgroState get initialState => SatAgroInitial();

  SatAgroBloc({required this.getField}) : super(SatAgroInitial()) {
    on<LoadField>((event, emit) async {
      final failuerOrField = await getField.call(const Params(id: 9999));
      await emit.onEach<SatAgroState>(eitherLoadedOrErrorState(failuerOrField!),
          onData: (fieldState) async {
        emit(Loading());
        add(_FieldLoaded(fieldState));
      });
    });
    on<_FieldLoaded>((event, emit) => emit(event.loadedState));

    on<ChangeMap>((event, emit) {
      emit(Loading());
      emit(MapFoundationChanged(mapType: event.mapType));
    });
    on<ErrorEvent>((event, emit) => emit(const Error(message: 'An error has occured')));
  }

  @visibleForTesting
  Stream<SatAgroState> eitherLoadedOrErrorState(Either<Failure, Field> failureOrField) async* {
    yield* failureOrField
        .fold((failure) => Stream.value(Error(message: mapFailureToMessage(failure))), (field) {
      if (field.area?.isNegative ?? false) {
        return Stream.value(const Error(message: AREA_IS_NEGATIVE));
      }
      List pointsAndHoles = field.getFieldPoints;
      return Stream.value(
          Loaded(field: field, points: pointsAndHoles.first, holes: pointsAndHoles.last));
    });
  }

  @visibleForTesting
  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
