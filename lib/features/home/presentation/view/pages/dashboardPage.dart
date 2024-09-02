import 'package:flutter/material.dart';

import '../HomeView.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Continue your learning journey.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          CustomCard(
            icon: Icons.play_circle_fill,
            title: 'Resume Course',
            subtitle: 'Continue from where you left off',
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 20),
          CustomCard(
            icon: Icons.assignment,
            title: 'New Quizzes Available',
            subtitle: 'Test your knowledge with new quizzes',
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}