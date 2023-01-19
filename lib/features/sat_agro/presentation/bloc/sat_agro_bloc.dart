
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sat_agro_event.dart';
part 'sat_agro_state.dart';

class SatAgroBloc extends Bloc<SatAgroEvent, SatAgroState> {
  SatAgroBloc() : super(SatAgroInitial()) {
    on<SatAgroEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
