import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/Entity/CategoryEntity.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryEntityModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String icon;

  const CategoryEntityModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.icon,
  });

  factory CategoryEntityModel.fromJson(Map<String, dynamic> json) => _$CategoryEntityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityModelToJson(this);

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      description: description,
      icon: icon,
    );
  }

  static CategoryEntityModel fromEntity(CategoryEntity entity) {
    return CategoryEntityModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      icon: entity.icon,
    );
  }

  @override
  List<Object?> get props => [id, name, description, icon];
}
