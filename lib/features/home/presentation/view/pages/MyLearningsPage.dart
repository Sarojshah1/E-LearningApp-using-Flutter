import 'package:flutter/material.dart';

import '../HomeView.dart';

class MyLearningsPage extends StatelessWidget {
  const MyLearningsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Learnings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Track your progress and achievements.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          CustomCard(
            icon: Icons.bar_chart,
            title: 'Learning Analytics',
            subtitle: 'View your course statistics',
            color: Colors.indigoAccent,
          ),
          const SizedBox(height: 20),
          CustomCard(
            icon: Icons.badge,
            title: 'Achievements',
            subtitle: 'Check your earned badges and certificates',
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}