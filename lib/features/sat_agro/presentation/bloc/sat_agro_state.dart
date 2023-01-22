part of 'sat_agro_bloc.dart';

abstract class SatAgroState extends Equatable {
  const SatAgroState();
  List<Object> get props => [];
}

class SatAgroInitial extends SatAgroState {
}

class Loaded extends SatAgroState {
  final Field field;
  final List<LatLng> points;
  final List<List<LatLng>> holes;

  Loaded({required this.field, required this.points, required this.holes});
}
class MapFoundationChanged extends SatAgroState {
  final MapType mapType;

  MapFoundationChanged({required this.mapType});
}

class Error extends SatAgroState {
  final String message;

  const Error({required this.message}) : super();
}
class Loading extends SatAgroState {}
