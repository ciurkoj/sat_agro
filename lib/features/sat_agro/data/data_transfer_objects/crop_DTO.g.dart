// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_DTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CropDTO _$CropDTOFromJson(Map<String, dynamic> json) => CropDTO(
      id: json['id'] as int?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      gddTbase: (json['gdd_tbase'] as num?)?.toDouble(),
      gddTut: (json['gdd_tut'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CropDTOToJson(CropDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('color', instance.color);
  writeNotNull('gdd_tbase', instance.gddTbase);
  writeNotNull('gdd_tut', instance.gddTut);
  return val;
}
