import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/StudyGroups/data/model/group_study_model.dart';
import '../viewmodel/study_group_viewModel.dart';

class StudyGroupCard extends ConsumerStatefulWidget {
  final String groupId;
  final String groupName;
  final String description;
  final Users createdBy;
  final int members;

  const StudyGroupCard({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.description,
    required this.createdBy,
    required this.members,
  }) : super(key: key);

  @override
  _StudyGroupCardState createState() => _StudyGroupCardState();
}

class _StudyGroupCardState extends ConsumerState<StudyGroupCard> {
  bool _isJoining = false; // Track if the joining process is in progress

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studyGroupViewModelProvider);

    return Card(
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
                    widget.groupName,
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
                    "http://10.0.2.2:3000/profile/${widget.createdBy.profilePicture}",
                  ),
                  backgroundColor: Colors.grey[200],
                ),
                SizedBox(width: 5.0),
                Text(
                  widget.createdBy.name,
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
              widget.description,
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
            SizedBox(height: 12.0),
            // Join button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: _isJoining ? null : () async {
                    setState(() {
                      _isJoining = true; // Set the joining state to true
                    });

                    final viewModel = ref.read(studyGroupViewModelProvider.notifier);
                    await viewModel.joinGroup(widget.groupId);
                    final state = ref.read(studyGroupViewModelProvider);


                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You have joined the group')),
                      );
                    

                    setState(() {
                      _isJoining = false; // Reset the joining state
                    });
                  },
                  icon: _isJoining
                      ? CircularProgressIndicator(color: Colors.white)
                      : Icon(Icons.add, color: Colors.white),
                  label: Text(
                    _isJoining ? 'Joining...' : 'Join Group',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: Colors.deepPurple.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
