
import 'package:flutter/material.dart';

import '../HomeView.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Courses',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Explore our wide range of courses.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          CustomCard(
            icon: Icons.computer,
            title: 'Introduction to Programming',
            subtitle: 'Start your coding journey',
            color: Colors.purpleAccent,
          ),
          const SizedBox(height: 20),
          CustomCard(
            icon: Icons.design_services,
            title: 'Graphic Design Basics',
            subtitle: 'Learn the fundamentals of design',
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}