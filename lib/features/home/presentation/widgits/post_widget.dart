import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../App/app.dart';
import '../../../FourmPosts/data/model/ForumPostModel.dart';
import '../../../FourmPosts/presentation/viewmodel/postViewModel.dart';

class PostWidget extends ConsumerStatefulWidget {
  final ForumPostModel post;

  PostWidget({required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends ConsumerState<PostWidget> with SingleTickerProviderStateMixin {
  bool _showComments = false;
  int _commentsToShow = 3; // Start with showing 3 comments
  Map<int, bool> _showReplies = {};
  Map<int, TextEditingController> _replyControllers = {};
  bool _isLiked = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showReplies = {
      for (int i = 0; i < (widget.post.comments.length ?? 0); i++) i: false,
    };
    _replyControllers = {
      for (int i = 0; i < (widget.post.comments.length ?? 0); i++) i: TextEditingController(),
    };
  }

  @override
  void dispose() {
    _replyControllers.forEach((_, controller) => controller.dispose());
    _commentController.dispose();
    super.dispose();
  }

  void _toggleReplies(int index) {
    setState(() {
      _showReplies[index] = !(_showReplies[index] ?? false);
    });
  }

  String _formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    String hour = (date.hour % 12 == 0 ? 12 : date.hour % 12).toString();
    String minute = date.minute.toString().padLeft(2, '0');
    String period = date.hour >= 12 ? 'PM' : 'AM';
    return '$month $day, $year at $hour:$minute $period';
  }

  String _getMonthName(int month) {
    const List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June', 'July',
      'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  void _addComment() async {
    if (_commentController.text.isNotEmpty) {
      final viewModel = ref.read(postViewModelProvider.notifier);
      await viewModel.addComment(widget.post.id, _commentController.text);
      setState(() {
        _commentController.clear();
        _showComments = true;
        _commentsToShow = 3;
      });
    }
  }

  void _addReply(int commentIndex, String commentId) async {
    final replyController = _replyControllers[commentIndex];
    if (replyController != null && replyController.text.isNotEmpty) {
      final newReplyText = replyController.text;
      final viewModel = ref.read(postViewModelProvider.notifier);
      await viewModel.addCommentReply(widget.post.id, commentId, newReplyText);
      setState(() {
        replyController.clear();
      });
    }
  }

  void _loadMoreComments() {
    setState(() {
      _commentsToShow += 3; // Load 3 more comments on each click
    });
  }

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postViewModelProvider);
    final post = postState.forumPosts
        .firstWhere((p) => p.id == widget.post.id, orElse: () => widget.post);
    final formattedDate = _formatDate(widget.post.createdAt);
    final totalComments = post.comments.length ?? 0;
    var totalLikes = widget.post.likes.length;
    final themeNotifier = ref.watch(themeNotifierProvider);
    bool isDarkMode = themeNotifier.isDarkMode;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.black12, Colors.black26]
                : [Colors.white, Colors.grey[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster Info
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "http://10.0.2.2:3000/profile/${widget.post.userId.profilePicture}"),
                    radius: 30.0,
                    backgroundColor:
                    isDarkMode ? Colors.white : Colors.blueGrey[100],
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      widget.post.userId.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color:
                        isDarkMode ? Colors.white : Colors.deepPurple[800],
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(
                    Icons.star,
                    color: Colors.yellow[700],
                    size: 20,
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                formattedDate,
                style: TextStyle(
                    color: isDarkMode ? Colors.white54 : Colors.grey[600],
                    fontSize: 14),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.post.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.deepPurple[800],
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.post.content,
                style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black87),
              ),
              SizedBox(height: 12.0),
              Wrap(
                spacing: 8.0,
                children: widget.post.tags.map((tag) {
                  return Chip(
                    label: Text(
                      '#$tag', // Add # before the tag
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: isDarkMode
                        ? Colors.blueAccent.withOpacity(0.2)
                        : Colors.blueAccent.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    shadowColor: isDarkMode
                        ? Colors.black54
                        : Colors.grey.withOpacity(0.3),
                  );
                }).toList(),
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(postViewModelProvider.notifier)
                          .addLike(widget.post.id);
                      setState(() {
                        _isLiked = !_isLiked;
                        totalLikes += _isLiked ? 1 : -1; // Adjust likes count
                      });
                    },
                    child: AnimatedScale(
                      scale: _isLiked ? 1.2 : 1.0,
                      duration: Duration(milliseconds: 200),
                      child: Icon(
                        _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                        color: _isLiked ? Colors.blue : Colors.grey,
                        size: 28,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text('$totalLikes', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 32.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showComments = !_showComments;
                      });
                    },
                    child: Icon(
                      Icons.comment_outlined,
                      size: 28,
                      color: _showComments ? Colors.blue : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text('$totalComments', style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(height: 16.0),
              if (_showComments)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0;
                    i < (post.comments.length > _commentsToShow
                        ? _commentsToShow
                        : post.comments.length);
                    i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "http://10.0.2.2:3000/profile/${post.comments[i].userId.profilePicture}"),
                            ),
                            title: Text(
                              post.comments[i].userId.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.deepPurple[800],
                              ),
                            ),
                            subtitle: Text(
                              post.comments[i].content,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white54 : Colors.black54,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _toggleReplies(i),
                            child: Text(
                              _showReplies[i] == true ? 'Hide Replies' : 'View Replies',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (_showReplies[i] == true)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var reply in post.comments[i].replies!)
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "http://10.0.2.2:3000/profile/${reply.userId.profilePicture}"),
                                    ),
                                    title: Text(
                                      reply.userId.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.deepPurple[800],
                                      ),
                                    ),
                                    subtitle: Text(
                                      reply.content,
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white54
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                TextField(
                                  controller: _replyControllers[i],
                                  decoration: InputDecoration(
                                    hintText: 'Write a reply...',
                                    filled: true,
                                    fillColor:isDarkMode ? Colors.black87: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.send,color: isDarkMode ? Colors.white:Colors.deepPurple),
                                      onPressed: () => _addReply(i, post.comments[i].id),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    if (totalComments > _commentsToShow)
                      TextButton(
                        onPressed: _loadMoreComments,
                        child: Text(
                          'Load More Comments',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                              filled: true,
                              fillColor:isDarkMode ? Colors.black87: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.send,color: isDarkMode ? Colors.white:Colors.deepPurple),
                                onPressed: _addComment,
                              ),
                            ),
                          ),)
                      ],
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
