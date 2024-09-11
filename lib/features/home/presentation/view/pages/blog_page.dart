import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/blog/presentation/view/blog_details_page.dart';
import 'package:llearning/features/blog/presentation/viewmodel/blog_view_model.dart';
import '../../../../blog/data/model/blog_model.dart';
import '../../../../blog/presentation/wigets/BlogCard.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BlogPage extends ConsumerStatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  ConsumerState<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends ConsumerState<BlogPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late ScrollController _scrollController;
  late TextEditingController _searchController;
  String _searchQuery = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      ref.read(blogViewModelProvider.notifier).getBlogs();
    });
    _searchController = TextEditingController();
    _searchController.addListener(_debounceSearchChanged);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.removeListener(_debounceSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      _loadMoreBlogs();
    }
  }

  Future<void> _loadMoreBlogs() async {
    final blogstate=ref.read(blogViewModelProvider);
    if(_isLoading || blogstate.hasReachedMax) return;
    setState(() {
      _isLoading = true;
    });
    await ref.read(blogViewModelProvider.notifier).getBlogs();
    setState(() {
      _isLoading = false;
    });


  }

  void _debounceSearchChanged() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_searchController.text == _searchQuery) return;
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }
  Future<void> _refreshBlogs() async {
    await ref.read(blogViewModelProvider.notifier).getBlogs();
  }

  void _onBlogCardTap(BlogModel blog) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogDetailPage(blog: blog)));
  }

  @override
  Widget build(BuildContext context) {
    final blogState = ref.watch(blogViewModelProvider);
    final List<BlogModel> blogs = blogState.blogs ?? [];
    final filteredBlogs = blogs.where((blog) {
      return blog.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
    print(blogState);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Explore Blogs',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshBlogs,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for blogs...',
                    prefixIcon: Icon(Icons.search, color: Colors.deepPurpleAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[400],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ),
              // Introduction Text
              const Text(
                'Explore a wide range of blogs.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              // List of Blogs
              Expanded(
                child: blogState.isLoading
                    ? Center(
                  child: LoadingAnimationWidget.twistingDots(
                    leftDotColor: const Color(0xFF1A1A3F),
                    rightDotColor: const Color(0xFFEA3799),
                    size: 50,
                  ),
                )

                    : ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredBlogs.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= filteredBlogs.length) {
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
                    final blog = filteredBlogs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: BlogCard(
                        blog: blog,
                        onCardTap: _onBlogCardTap,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for adding a new blog
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
