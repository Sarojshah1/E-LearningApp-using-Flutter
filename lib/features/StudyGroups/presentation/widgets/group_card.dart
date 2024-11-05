import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/StudyGroups/data/model/group_study_model.dart';
import '../view/GroupDetailPage.dart';
import '../viewmodel/study_group_viewModel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GroupCard extends ConsumerStatefulWidget {
  final String? groupId;
  final String? groupName;
  final String? description;
  final Users? createdBy;
  final int? members;

  const GroupCard({
    Key? key,
    this.groupId,
    required this.groupName,
    required this.description,
    required this.createdBy,
    required this.members,
  }) : super(key: key);

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends ConsumerState<GroupCard> {
  bool _isJoining = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studyGroupViewModelProvider);

    return InkWell(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupDetailPage(groupId: widget.groupId),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade50, Colors.purple.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.1),
                blurRadius: 8.0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group name and creator info
              Row(
                children: [
                  Icon(Icons.groups, color: Colors.deepPurple, size: 32),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      widget.groupName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.deepPurple.shade900,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(
                      "http://10.0.2.2:3000/profile/${widget.createdBy!.profilePicture}",
                    ),
                    backgroundColor: Colors.grey[200],
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    widget.createdBy!.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.deepPurple.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              // Description
              Text(
                widget.description!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10.0),
              // Member list
              Row(
                children: [
                  Icon(Icons.group, color: Colors.deepPurple),
                  SizedBox(width: 8.0),
                  Text(
                    "${widget.members} members",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
