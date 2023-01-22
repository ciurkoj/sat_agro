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

  get getFieldPoints {
    List<LatLng> points = [];
    List<List<LatLng>> holes = [];
    bool isFieldPolygon = true;
      final re = RegExp(r"\(([^(].*?[^)])\)");
      Iterable<Match> allMatches = re.allMatches(geom!);
      for (Match m in allMatches) {
        List<LatLng> coordinateList = [];
        m[1]!.trim().split(', ').forEach((element) {
          coordinateList.add(LatLng(double.parse(element.trim().split(' ').last),
              double.parse(element.trim().split(' ').first)));
        });
        if (isFieldPolygon) {
          points.addAll(coordinateList);
          // after first iteration it switches to holes list
          isFieldPolygon = false;
        } else {
          holes.add(coordinateList);
        }
      }
    return [points, holes];
  }
}
