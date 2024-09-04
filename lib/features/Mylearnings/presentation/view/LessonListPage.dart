import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Courses/Presentation/viewmodel/courseViewModel.dart';
import 'content_page.dart';

class LessonListPage extends ConsumerStatefulWidget {
   final String courseId;
  const LessonListPage({super.key,required this.courseId});

  @override
  _LessonListPageState createState() => _LessonListPageState();
}

class _LessonListPageState extends ConsumerState<LessonListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref.read(courseViewModelProvider.notifier).getcourceById(widget.courseId);
    });
  }
  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(courseViewModelProvider);
    print(courseState.course);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lessons",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: courseState.course?.lessons.length,
          itemBuilder: (context, index) {
            final lesson = courseState.course?.lessons[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  lesson!.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                // subtitle: Text(
                //   lesson.,
                //   style: TextStyle(color: Colors.black54),
                // ),
                leading: Icon(
                  Icons.book,
                  color: Colors.blueAccent,
                ),
                onTap: () {
                  // Handle lesson tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFViewPage(
                        pdfUrl: lesson.content, // Assuming content holds the PDF URL
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
