// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_study_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) {
  return Users(
    id: json['_id'] as String,
    name: json['name'] as String,
    profilePicture: json['profile_picture'] as String,
  );
}

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'profilePicture': instance.profilePicture,
};

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    sender: Users.fromJson(json['sender'] as Map<String, dynamic>),
    message: json['message'] as String,
    sentAt: DateTime.parse(json['sent_at'] as String),
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
  'sender': instance.sender.toJson(),
  'message': instance.message,
  'sentAt': instance.sentAt.toIso8601String(),
};

GroupStudy _$GroupStudyFromJson(Map<String, dynamic> json) {
  return GroupStudy(
    id: json['_id'],
    groupName: json['group_name'] as String,
    description: json['description'] as String,
    createdBy: Users.fromJson(json['created_by'] as Map<String, dynamic>),
    members: (json['members'] as List<dynamic>)
        .map((e) => Users.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdAt: DateTime.parse(json['created_at'] as String),
    chats: (json['chats'] as List<dynamic>)
        .map((e) => Chat.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GroupStudyToJson(GroupStudy instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'groupName': instance.groupName,
      'description': instance.description,
      'createdBy': instance.createdBy.toJson(),
      'members': instance.members.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'chats': instance.chats.map((e) => e.toJson()).toList(),
    };
