import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Courses/Presentation/view/CourseDetailsPage.dart';
import 'dart:async';
import '../../../../Courses/Presentation/viewmodel/courseViewModel.dart';
import '../../../../Courses/Presentation/widgets/CourseCard.dart';

class CoursesPage extends ConsumerStatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends ConsumerState<CoursesPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late ScrollController _scrollController;
  bool _isLoading=false;
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
    super.dispose();
  }



  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      _loadMoreCourses();
    }
  }
  Future<void> _loadMoreCourses() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) { // Check if the widget is still mounted
      // ref.read(courseViewModelProvider.notifier).loadMoreCourses();
      _refreshIndicatorKey.currentState?.show();
    }
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


  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(courseViewModelProvider);
    final filteredCourses=courseState.courses.where((course){
      return course.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80, // Increased height for more prominence
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Courses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Roboto', // Custom font
                ),
              ),
            ),
          ],
        ),
        elevation: 0, // Removing default elevation
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _loadMoreCourses,
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
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // List of Courses
              Expanded(
                child: courseState.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : courseState.error != null
                    ? Center(child: Text('Error: ${courseState.error}'))
                    : courseState.courses == null || courseState.courses!.isEmpty
                    ? Center(child: Text('No courses found.'))
                    : ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    final course = filteredCourses[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: CourseCard(
                        thumbnail: course.thumbnail,
                        title: course.title,
                        description: course.description,
                        price: "${course.price}",
                        duration: course.duration,
                        level: course.level,
                        creator: course.createdBy.name,
                        onEnroll: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CourseDetailsPage(course: course)));
                        },
                      ),
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
