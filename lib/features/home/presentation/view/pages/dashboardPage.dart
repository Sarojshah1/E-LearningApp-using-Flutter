import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/FourmPosts/data/model/ForumPostModel.dart';
import 'package:llearning/features/FourmPosts/presentation/view/CreatePostPage.dart';
import 'package:llearning/features/FourmPosts/presentation/viewmodel/postViewModel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class ForumPostPage extends ConsumerStatefulWidget {
  @override
  _ForumPostPageState createState() => _ForumPostPageState();
}


class _ForumPostPageState extends ConsumerState<ForumPostPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late ScrollController _scrollController;
  bool _isLoading = false;
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(postViewModelProvider.notifier).getPost();
      setState(() {
        _isInitialLoad = false; // Update state after initial load
      });
    });
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    final postState = ref.read(postViewModelProvider);
    if (_isLoading || postState.hasReachedMax) return;
    setState(() {
      _isLoading = true;
    });
    Future.microtask(() {
      ref.read(postViewModelProvider.notifier).getPost();

    });
    // await ref.read(postViewModelProvider.notifier).getPost();
    setState(() {
      _isLoading = false;
    });
  }


  void _createPost() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreatePostPage()));
  }

  Future<void> _refreshPosts() async {
    await ref.read(postViewModelProvider.notifier).getPost();
  }

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postViewModelProvider);
    final posts = postState.forumPosts ?? [];
    final sortedPosts = (posts ?? []).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshPosts,
        child:_isInitialLoad
            ? Center(
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: const Color(0xFF1A1A3F),
            rightDotColor: const Color(0xFFEA3799),
            size: 50,
          ),
        )
            :  ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(8.0),
          itemCount:sortedPosts.length,
          itemBuilder: (context, index) {
            if (index >= sortedPosts.length) {

              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: LoadingAnimationWidget.twistingDots(
                    leftDotColor: const Color(0xFF1A1A3F),
                    rightDotColor: const Color(0xFFEA3799),
                    size: 50,
                  ),
                ),
              );
            }
            return PostWidget(post: sortedPosts[index]);
          },
        ),
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
  int _commentsToShow = 3; // Start with showing 3 comments
  Map<int, bool> _showReplies = {};
  Map<int, TextEditingController> _replyControllers = {};
  bool _isLiked = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showReplies = {
      for (int i = 0; i < (widget.post.comments?.length ?? 0); i++) i: false,
    };
    _replyControllers = {
      for (int i = 0; i < (widget.post.comments?.length ?? 0); i++) i: TextEditingController(),
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
        _commentsToShow = 3; // Reset to show 3 comments
      });
    }
  }

  void _addReply(int commentIndex, String commentId) async {
    if (_replyControllers[commentIndex]!.text.isNotEmpty) {
      final newReplyText = _replyControllers[commentIndex]!.text;
      final viewModel = ref.read(postViewModelProvider.notifier);
      await viewModel.addCommentReply(
          widget.post.id, commentId, newReplyText);
      setState(() {

        _replyControllers[commentIndex]!.clear();
        _showReplies[commentIndex] = false; // Hide replies after adding
      });
    }
  }

  void _likePost() {
    ref.read(postViewModelProvider.notifier).addLike(widget.post.id);
    setState(() {
      _isLiked = !_isLiked;
    });
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
    final totalComments = post.comments?.length ?? 0;
    final totalLikes=post.likes.length;
    print(post.comments);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
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
            Text(
              formattedDate,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.post.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.post.content,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 12.0),
            Wrap(
              spacing: 8.0,
              children: widget.post.tags
                  .map(
                    (tag) => Chip(
                  label: Text(tag),
                  backgroundColor: Colors.blueAccent.withOpacity(0.1),
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              )
                  .toList(),
            ),
            SizedBox(height: 12.0),
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
                Text('$totalLikes', style: TextStyle(fontSize: 16)),
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
                        _showComments
                            ? 'Hide Comments'
                            : 'Show Comments ($totalComments)',
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            if (_showComments)

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = (totalComments - 1);
                  i >= 0 && i >= totalComments - _commentsToShow; i--)

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "http://10.0.2.2:3000/profile/${widget.post.comments![i].userId.profilePicture}"
                                  ),
                                  radius: 18.0,
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    post.comments[i].userId.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  _formatDate(widget.post.comments[i].createdAt),
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              post.comments![i].content,
                              style: TextStyle(color: Colors.black87, fontSize: 14),
                            ),
                            SizedBox(height: 8.0),
                            if (_showReplies[i] ?? false)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var reply in post.comments![i].replies ?? [])
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 4.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "http://10.0.2.2:3000/profile/${reply.userId.profilePicture}"
                                              ),
                                              radius: 18.0,
                                            ),
                                            SizedBox(width: 8.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    reply.userId.name,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Colors.deepPurple,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  Text(
                                                    reply.content,
                                                    style: TextStyle(color: Colors.black87, fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            TextButton(
                              onPressed: () => _toggleReplies(i),
                              child: Text(
                                _showReplies[i] ??false ? 'Hide Replies' : 'Show Replies (${post.comments![i].replies?.length ?? 0})',
                                style: TextStyle(color: Colors.blue, fontSize: 14),
                              ),
                            ),
                            if (_showReplies[i] ?? false)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _replyControllers[i],
                                        decoration: InputDecoration(
                                          hintText: 'Write a reply...',
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.send),
                                            onPressed: () => _addReply(i, post.comments![i].id),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  if (_commentsToShow < totalComments)
                    Center(
                      child: TextButton(
                        onPressed: _loadMoreComments,
                        child: Text('Load More', style: TextStyle(color: Colors.blue, fontSize: 14)),
                      ),
                    ),
                ],
              ),
            SizedBox(height: 12.0),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

