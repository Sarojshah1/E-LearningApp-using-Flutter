import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/FourmPosts/data/model/ForumPostModel.dart';
import 'package:llearning/features/FourmPosts/presentation/view/CreatePostPage.dart';
import 'package:llearning/features/FourmPosts/presentation/viewmodel/postViewModel.dart';

class ForumPostPage extends ConsumerStatefulWidget {
  @override
  _ForumPostPageState createState() => _ForumPostPageState();
}

class _ForumPostPageState extends ConsumerState<ForumPostPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(postViewModelProvider.notifier).getPost();
    });
  }

  void _createPost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage()));
  }

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postViewModelProvider);
    final posts = postState.forumPosts;

    return Scaffold(
      appBar: AppBar(
        title: Text('Forum Posts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createPost,
            tooltip: 'Create Post',
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: posts.map((post) => PostWidget(post: post)).toList(),
      ),
    );
  }
}

class PostWidget extends ConsumerStatefulWidget {
  final ForumPostModel post;

  PostWidget({required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends ConsumerState<PostWidget> {
  bool _showComments = false;
  Map<int, bool> _showReplies = {};
  Map<int, TextEditingController> _replyControllers = {};
  bool _isLiked = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showReplies = {
      for (int i = 0; i < widget.post.comments.length; i++) i: false,
    };
    _replyControllers = {
      for (int i = 0; i < widget.post.comments.length; i++) i: TextEditingController(),
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
      _showReplies[index] = !_showReplies[index]!;
    });
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        // Implement adding a comment here
        _commentController.clear();
      });
    }
  }

  void _addReply(int commentIndex) {
    final controller = _replyControllers[commentIndex];
    if (controller != null && controller.text.isNotEmpty) {
      setState(() {
        // Implement adding a reply here
        controller.clear();
      });
    }
  }

  void _likePost() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
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
                  backgroundImage: NetworkImage("http://10.0.2.2:3000/profile/${widget.post.userId.profilePicture}"),
                  radius: 24.0,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    widget.post.userId.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Icon(
                  Icons.star,
                  color: Colors.yellow[700],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            // Title
            Text(
              widget.post.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 8.0),
            // Content
            Text(
              widget.post.content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.0),
            // Tags
            Wrap(
              spacing: 8.0,
              children: widget.post.tags.map((tag) => Chip(
                label: Text(tag),
                backgroundColor: Colors.blueAccent.withOpacity(0.1),
                labelStyle: TextStyle(color: Colors.blueAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              )).toList(),
            ),
            SizedBox(height: 12.0),
            // Likes and Comments
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    color: _isLiked ? Colors.blue : Colors.grey,
                  ),
                  onPressed: _likePost,
                ),
                SizedBox(width: 4.0),
                Text('${widget.post.likes.length}'),
                SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showComments = !_showComments;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.comment, size: 18, color: Colors.blue),
                      SizedBox(width: 4.0),
                      Text(
                        _showComments ? 'Hide Comments' : 'Show Comments (${widget.post.comments.length})',
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            // Comments
            if (_showComments)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.post.comments.asMap().entries.map((entry) {
                  int index = entry.key;
                  final comment = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage("http://10.0.2.2:3000/profile/${comment.userId.profilePicture}"),
                                radius: 24.0,
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  '${comment.userId.name}: ${comment.content}',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.0),
                          GestureDetector(
                            onTap: () => _toggleReplies(index),
                            child: Text(
                              _showReplies[index]! ? 'Hide Replies' : 'Show Replies (${comment.replies.length})',
                              style: TextStyle(color: Colors.blue, fontSize: 14),
                            ),
                          ),
                          if (_showReplies[index]!)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: comment.replies.map((reply) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 32.0, top: 4.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage("http://10.0.2.2:3000/profile/${reply.userId.profilePicture}"),
                                        radius: 24.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                          '${reply.userId.name}: ${reply.content}',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _replyControllers[index],
                                  decoration: InputDecoration(
                                    hintText: 'Write a reply...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              ElevatedButton(
                                onPressed: () => _addReply(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text('Reply'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            SizedBox(height: 16.0),
            // Add Comment
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _addComment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Comment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
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