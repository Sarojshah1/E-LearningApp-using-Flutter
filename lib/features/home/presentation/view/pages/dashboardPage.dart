import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/FourmPosts/presentation/view/CreatePostPage.dart';

// Define your data models
class Post {
  final String title;
  final String content;
  final List<String> tags;
  final int likes;
  final List<Comment> comments;
  final String posterName;
  final String posterProfileUrl;

  Post({
    required this.title,
    required this.content,
    required this.tags,
    required this.likes,
    required this.comments,
    required this.posterName,
    required this.posterProfileUrl,
  });
}

class Comment {
  final String userName;
  final String comment;
  final List<Reply> replies;

  Comment({
    required this.userName,
    required this.comment,
    required this.replies,
  });
}

class Reply {
  final String userName;
  final String reply;

  Reply({
    required this.userName,
    required this.reply,
  });
}

class ForumPostPage extends ConsumerStatefulWidget {
  @override
  _ForumPostPageState createState() => _ForumPostPageState();
}

class _ForumPostPageState extends ConsumerState<ForumPostPage> {
  final List<Post> posts = List.generate(
    10,
        (index) => Post(
      title: 'Post Title $index',
      content: 'This is the content of post number $index. It contains interesting information about Flutter development and other related topics.',
      tags: ['Tag${index % 3}', 'Tag${(index + 1) % 3}', 'Tag${(index + 2) % 3}'],
      likes: (index + 1) * 10,
      comments: List.generate(
        (index % 3) + 1,
            (commentIndex) => Comment(
          userName: 'User${index * 10 + commentIndex}',
          comment: 'This is a comment number $commentIndex on post number $index.',
          replies: List.generate(
            (commentIndex % 2) + 1,
                (replyIndex) => Reply(
              userName: 'ReplyUser${index * 10 + commentIndex * 10 + replyIndex}',
              reply: 'This is a reply number $replyIndex to comment number $commentIndex on post number $index.',
            ),
          ),
        ),
      ),
      posterName: 'Poster $index',
      posterProfileUrl: 'https://randomuser.me/api/portraits/men/${index % 10}.jpg',
    ),
  );

  void _createPost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage()));
  }

  @override
  Widget build(BuildContext context) {
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
  final Post post;

  PostWidget({required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends ConsumerState<PostWidget> {
  bool _showComments = false;
  Map<int, bool> _showReplies = {};
  Map<int, TextEditingController> _replyControllers = {};
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _showReplies = Map.fromIterable(
      List.generate(widget.post.comments.length, (index) => index),
      key: (index) => index,
      value: (index) => false,
    );

    // Initialize controllers for each comment's replies
    _replyControllers = Map.fromIterable(
      List.generate(widget.post.comments.length, (index) => index),
      key: (index) => index,
      value: (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers to avoid memory leaks
    _replyControllers.forEach((key, controller) => controller.dispose());
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
        widget.post.comments.add(Comment(
          userName: 'NewUser',
          comment: _commentController.text,
          replies: [],
        ));
        _commentController.clear();
      });
    }
  }

  void _addReply(int commentIndex) {
    final controller = _replyControllers[commentIndex];
    if (controller != null && controller.text.isNotEmpty) {
      setState(() {
        widget.post.comments[commentIndex].replies.add(Reply(
          userName: 'NewUser',
          reply: controller.text,
        ));
        controller.clear();
      });
    }
  }

  void _likePost() {
    setState(() {
      _isLiked = !_isLiked;
      print(_isLiked ? 'Liked' : 'Unliked');
    });
  }

  final TextEditingController _commentController = TextEditingController();

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
                  backgroundImage: NetworkImage(widget.post.posterProfileUrl),
                  radius: 24.0,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    widget.post.posterName,
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
              children: widget.post.tags
                  .map((tag) => Chip(
                label: Text(tag),
                backgroundColor: Colors.blueAccent.withOpacity(0.1),
                labelStyle: TextStyle(color: Colors.blueAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ))
                  .toList(),
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
                Text('${widget.post.likes}'),
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
                  Comment comment = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Container(
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
                                  backgroundColor: Colors.grey[300],
                                  child: Text(comment.userName[0], style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    '${comment.userName}: ${comment.comment}',
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
                                children: [
                                  ...comment.replies.map((reply) => Padding(
                                    padding: const EdgeInsets.only(left: 32.0, top: 4.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey[300],
                                          child: Text(reply.userName[0], style: TextStyle(color: Colors.white)),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            '${reply.userName}: ${reply.reply}',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
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
                                         backgroundColor: Colors.blueAccent, // Button color
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
                          ],
                        ),
                      ),
                    ],
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
                    backgroundColor: Colors.blueAccent, // Button color
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
