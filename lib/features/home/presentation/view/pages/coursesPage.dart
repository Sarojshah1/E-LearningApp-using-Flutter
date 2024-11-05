import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Courses/Presentation/view/CourseDetailsPage.dart';
import 'package:llearning/features/Courses/Presentation/viewmodel/courseViewModel.dart';
import 'package:llearning/features/Courses/Presentation/widgets/CourseCard.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CoursesPage extends ConsumerStatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends ConsumerState<CoursesPage> {
  late ScrollController _scrollController;
  bool _isLoading = false;
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _searchController = TextEditingController();
    _searchController.addListener(_debounceSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      _loadMoreCourses();
    }
  }

  Future<void> _loadMoreCourses() async {
    final courseState = ref.read(courseViewModelProvider);
    if (_isLoading || courseState.hasReachedMax) return; // Prevent multiple loads or loading when no more courses are available
    setState(() {
      _isLoading = true;
    });
    await ref.read(courseViewModelProvider.notifier).getCourses();
    setState(() {
      _isLoading = false;
    });
  }

  void _debounceSearchChanged() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_searchController.text == _searchQuery) return; // Prevent unnecessary rebuilds
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  Future<void> _refreshCourses() async {
    await ref.read(courseViewModelProvider.notifier).getCourses();
  }

  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(courseViewModelProvider);
    final filteredCourses = courseState.courses.where((course) {
      return course.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Courses',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCourses,
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
                    hintText: 'Search for courses...',
                    prefixIcon: Icon(Icons.search, color: Colors.teal),
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
                'Explore our wide range of courses.',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // List of Courses or GridView
              Expanded(
                child: isTablet
                    ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: filteredCourses.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= filteredCourses.length) {
                      // Show a loading indicator at the bottom if more courses are being fetched
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
                    final course = filteredCourses[index];
                    return CourseCard(
                      thumbnail: course.thumbnail,
                      title: course.title,
                      description: course.description,
                      price: "${course.price}",
                      duration: course.duration,
                      level: course.level,
                      creator: course.createdBy.name,
                      onEnroll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailsPage(course: course),
                          ),
                        );
                      },
                    );
                  },
                )
                    : ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredCourses.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= filteredCourses.length) {
                      // Show a loading indicator at the bottom if more courses are being fetched
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
                    final course = filteredCourses[index];
                    return CourseCard(
                      thumbnail: course.thumbnail,
                      title: course.title,
                      description: course.description,
                      price: "${course.price}",
                      duration: course.duration,
                      level: course.level,
                      creator: course.createdBy.name,
                      onEnroll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailsPage(course: course),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
