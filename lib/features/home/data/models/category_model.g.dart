// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryEntityModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntityModel _$CategoryEntityModelFromJson(Map<String, dynamic> json) {
  return CategoryEntityModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    description: json['description'] as String? ?? '',
    icon: json['icon'] as String,
  );
}

Map<String, dynamic> _$CategoryEntityModelToJson(CategoryEntityModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
    };
