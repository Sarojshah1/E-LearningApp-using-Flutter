import 'package:equatable/equatable.dart';

class Users extends Equatable{
  final String name;
  final String profile_picture;

  Users({
    required this.name,
    required this.profile_picture
});
  @override
  List<Object> get props=>[name,profile_picture];
}
class Chat extends Equatable {
  final Users sender;
  final String message;
  final DateTime sentAt;

  Chat({
    required this.sender,
    required this.message,
    required this.sentAt,
  });

  @override
  List<Object> get props => [sender, message, sentAt];
}

class GroupStudy extends Equatable {
  final String? id;
  final String groupName;
  final String description;
  final Users createdBy;
  final List<Users> members;
  final DateTime createdAt;
  final List<Chat> chats;

  GroupStudy({
    this.id,
    required this.groupName,
    required this.description,
    required this.createdBy,
    required this.members,
    required this.createdAt,
    required this.chats,
  });

  @override
  List<Object?> get props => [
    id,
    groupName,
    description,
    createdBy,
    members,
    createdAt,
    chats,
  ];
}
