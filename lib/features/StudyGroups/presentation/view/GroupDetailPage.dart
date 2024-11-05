import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/App/constants/formatdate.dart';
import 'package:llearning/features/StudyGroups/data/model/group_study_model.dart';
import '../viewmodel/study_group_viewModel.dart'; // ViewModel
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GroupDetailPage extends ConsumerStatefulWidget {
  final String? groupId;

  const GroupDetailPage({
    Key? key,
     this.groupId,
  }) : super(key: key);

  @override
  _GroupDetailPageState createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends ConsumerState<GroupDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(studyGroupViewModelProvider.notifier).getGroupsById(widget.groupId!);
    });
    Future.microtask(() {
      _scrollToBottom();
    });
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      ref.read(studyGroupViewModelProvider.notifier).getGroupsById(widget.groupId!);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() async {
    final viewModel = ref.read(studyGroupViewModelProvider.notifier);
    if (_messageController.text.isNotEmpty) {
      await viewModel.sendMessage(widget.groupId!, _messageController.text);
      _messageController.clear();
    }
    Future.microtask(() {
      ref.read(studyGroupViewModelProvider.notifier).getGroupsById(widget.groupId!);
    });
    Future.microtask(() {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studyGroupViewModelProvider);
    final group = state.group;

    if(state.isLoading){
      Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color(0xFF1A1A3F),
          rightDotColor: const Color(0xFFEA3799),
          size: 50,
        ),
      );
    }
   

    return Scaffold(
      appBar: AppBar(
        title: Text(
          group!.groupName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16.0),
              itemCount: group.chats.length,
              itemBuilder: (context, index) {
                final message = group.chats[index];
                return _buildMessageTile(message);
              },

            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Message Tile Widget
  Widget _buildMessageTile(Chat message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            radius: 24,
            backgroundImage: CachedNetworkImageProvider(
              "http://10.0.2.2:3000/profile/${message.sender.profilePicture}",
            ),
          ),
          SizedBox(width: 10),
          // Message content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sender's name
                Text(
                  message.sender.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                // The message text
                Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(top: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                // Timestamp
                Text(
                  FormatDate.formatDateOnly(message.sentAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Message Input Widget
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                ),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.send, color: Colors.deepPurple),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
