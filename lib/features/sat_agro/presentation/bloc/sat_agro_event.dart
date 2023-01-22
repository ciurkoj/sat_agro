part of 'sat_agro_bloc.dart';

abstract class SatAgroEvent extends Equatable {
  const SatAgroEvent();
  List<Object?> get props => [];

}
class LoadField extends SatAgroEvent {
}

class ChangeMap extends SatAgroEvent {
  final MapType mapType;

  ChangeMap(this.mapType);
}
class _FieldLoaded extends SatAgroEvent {
  const _FieldLoaded(this.loadedState);

  final SatAgroState loadedState;

  @override
  List<Object> get props => [loadedState];
}
// for current demonstration purposes
class ErrorEvent extends SatAgroEvent {
}
