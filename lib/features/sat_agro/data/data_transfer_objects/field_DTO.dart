import 'package:satagro/features/sat_agro/data/data_transfer_objects/crop_history_DTO.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:satagro/features/sat_agro/domain/entities/field.dart';

part 'field_DTO.g.dart';

@JsonSerializable(includeIfNull: false)
class FieldDTO extends Field {
  int? id;
  int? user;
  String? name;
  String? comment;
  String? geom;
  @JsonKey(name: 'crop_history')
  List<CropHistoryDTO>? cropHistory;
  @JsonKey(name: 'area_ag')
  double? areaAg;
  String? status;
  double? hectares;
  double? area;
  String? created;

  FieldDTO({
    required this.id,
    required this.user,
    required this.name,
    this.comment,
    required this.geom,
    this.cropHistory,
    this.areaAg,
    this.status,
    this.hectares,
    this.area,
    this.created,
  }): super(id:id,
  user:user,
  name:name,
  geom:geom);

  factory FieldDTO.fromJson(Map<String, dynamic> json) => _$FieldDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FieldDTOToJson(this);

}
