import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Courses/data/model/UserEntityModelforCourse.dart';

import '../../../Courses/data/model/course_model.dart';
import '../../data/model/mylearningModel.dart';
import '../viewmodel/MyLearning_view_model.dart';
import '../widgets/MyLearningsCard.dart';

class MyLearningPage extends ConsumerStatefulWidget {
  const MyLearningPage({Key? key}) : super(key: key);

  @override
  _MyLearningPageState createState() => _MyLearningPageState();
}

class _MyLearningPageState extends ConsumerState<MyLearningPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref.read(myLearningViewModelProvider.notifier).getLearning();
    });
  }
  @override
  Widget build(BuildContext context) {
    final enrolledState = ref.watch(myLearningViewModelProvider);
    print(enrolledState.enrolled);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'My Learnings',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add notifications functionality here
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: enrolledState.enrolled.isEmpty
          ? Center(child: Text('No courses found'))
          : ListView.builder(
        itemCount: enrolledState.enrolled.length,
        itemBuilder: (context, index) {
          return MyLearningsCard(course: enrolledState.enrolled[index]);
        },
      ),
    );
  }
}
