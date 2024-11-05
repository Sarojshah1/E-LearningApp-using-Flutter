import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/FourmPosts/presentation/view/CreatePostPage.dart';
import 'package:llearning/features/FourmPosts/presentation/viewmodel/postViewModel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../FourmPosts/presentation/widgets/MyAppBar.dart';
import '../../widgits/post_widget.dart';
class ForumPostPage extends ConsumerStatefulWidget  {
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
      appBar: MyAppBar(),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshPosts,
        child: ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(8.0),
          itemCount:sortedPosts.length + (_isLoading ? 1 : 0),
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
            final post=sortedPosts[index];
            return PostWidget(post: post);
          },
        ),
      ),
    );
  }
}

