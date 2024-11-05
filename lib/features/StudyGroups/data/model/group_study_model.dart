import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'group_study_model.g.dart'; // Required for code generation

@JsonSerializable()
class Users extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String profilePicture;

  const Users({
    required this.id,
    required this.name,
    required this.profilePicture,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  Users copyWith({
    String? id,
    String? name,
    String? profilePicture,
  }) {
    return Users(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  List<Object?> get props => [id, name, profilePicture];
}

@JsonSerializable()
class Chat extends Equatable {
  final Users sender;
  final String message;
  final DateTime sentAt;

  const Chat({
    required this.sender,
    required this.message,
    required this.sentAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);

  Chat copyWith({
    Users? sender,
    String? message,
    DateTime? sentAt,
  }) {
    return Chat(
      sender: sender ?? this.sender,
      message: message ?? this.message,
      sentAt: sentAt ?? this.sentAt,
    );
  }

  @override
  List<Object?> get props => [sender, message, sentAt];
}
@JsonSerializable()
class GroupStudy extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String groupName;
  final String description;
  final Users createdBy;
  final List<Users> members;
  final DateTime createdAt;
  final List<Chat> chats;

  const GroupStudy({
    this.id,
    required this.groupName,
    required this.description,
    required this.createdBy,
    required this.members,
    required this.createdAt,
    required this.chats,
  });

  factory GroupStudy.fromJson(Map<String, dynamic> json) => _$GroupStudyFromJson(json);
  Map<String, dynamic> toJson() => _$GroupStudyToJson(this);

  GroupStudy copyWith({
    String? id,
    String? groupName,
    String? description,
    Users? createdBy,
    List<Users>? members,
    DateTime? createdAt,
    List<Chat>? chats,
  }) {
    return GroupStudy(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object?> get props => [id, groupName, description, createdBy, members, createdAt, chats];
}
