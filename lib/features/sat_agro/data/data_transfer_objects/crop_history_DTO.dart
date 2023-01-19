import 'package:satagro/features/sat_agro/data/data_transfer_objects/crop_DTO.dart';
import 'package:json_annotation/json_annotation.dart';
part 'crop_history_DTO.g.dart';

@JsonSerializable(includeIfNull: false)
class CropHistoryDTO {
  int? id;
  CropDTO? crop;
  String? label;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  double? yields;
  @JsonKey(name: 'yields_forecast')
  double? yieldsForecast;

CropHistoryDTO({
    this.id,
    this.crop,
    this.label,
    this.startDate,
    this.endDate,
    this.yields,
    this.yieldsForecast,
  });

  factory CropHistoryDTO.fromJson(Map<String, dynamic> json) => _$CropHistoryDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CropHistoryDTOToJson(this);

}
