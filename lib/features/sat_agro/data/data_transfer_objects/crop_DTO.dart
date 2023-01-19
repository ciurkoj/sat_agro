import 'package:json_annotation/json_annotation.dart';
part 'crop_DTO.g.dart';

@JsonSerializable(includeIfNull: false)
class CropDTO {
  int? id;
  String? name;
  String? color;
  @JsonKey(name: 'gdd_tbase')
  double? gddTbase;
  @JsonKey(name: 'gdd_tut')
  double? gddTut;

  CropDTO({
    this.id,
    this.name,
    this.color,
    this.gddTbase,
    this.gddTut,
  });
  factory CropDTO.fromJson(Map<String, dynamic> json) => _$CropDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CropDTOToJson(this);

}
