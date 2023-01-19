// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_history_DTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CropHistoryDTO _$CropHistoryDTOFromJson(Map<String, dynamic> json) =>
    CropHistoryDTO(
      id: json['id'] as int?,
      crop: json['crop'] == null
          ? null
          : CropDTO.fromJson(json['crop'] as Map<String, dynamic>),
      label: json['label'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      yields: (json['yields'] as num?)?.toDouble(),
      yieldsForecast: (json['yields_forecast'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CropHistoryDTOToJson(CropHistoryDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('crop', instance.crop);
  writeNotNull('label', instance.label);
  writeNotNull('start_date', instance.startDate);
  writeNotNull('end_date', instance.endDate);
  writeNotNull('yields', instance.yields);
  writeNotNull('yields_forecast', instance.yieldsForecast);
  return val;
}
