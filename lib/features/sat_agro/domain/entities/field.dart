import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Field extends Equatable {
  int? id;
  int? user;
  String? name;
  String? geom;
  double? area;

  Field({
    this.id,
    this.user,
    this.name,
    this.geom,
    this.area,
  });

  @override
  List<Object?> get props => [];

  List<LatLng>? get getFieldPoints {
    return [];
  }
}
