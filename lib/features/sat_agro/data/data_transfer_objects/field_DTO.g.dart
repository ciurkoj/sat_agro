// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_DTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldDTO _$FieldDTOFromJson(Map<String, dynamic> json) => FieldDTO(
      id: json['id'] as int?,
      user: json['user'] as int?,
      name: json['name'] as String?,
      comment: json['comment'] as String?,
      geom: json['geom'] as String?,
      cropHistory: (json['crop_history'] as List<dynamic>?)
          ?.map((e) => CropHistoryDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      areaAg: (json['area_ag'] as num?)?.toDouble(),
      status: json['status'] as String?,
      hectares: (json['hectares'] as num?)?.toDouble(),
      area: (json['area'] as num?)?.toDouble(),
      created: json['created'] as String?,
    );

Map<String, dynamic> _$FieldDTOToJson(FieldDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user', instance.user);
  writeNotNull('name', instance.name);
  writeNotNull('comment', instance.comment);
  writeNotNull('geom', instance.geom);
  writeNotNull('crop_history', instance.cropHistory);
  writeNotNull('area_ag', instance.areaAg);
  writeNotNull('status', instance.status);
  writeNotNull('hectares', instance.hectares);
  writeNotNull('area', instance.area);
  writeNotNull('created', instance.created);
  return val;
}
