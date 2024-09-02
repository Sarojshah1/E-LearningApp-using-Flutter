import 'package:flutter/material.dart';

class ViewActivityPage extends StatelessWidget {
  const ViewActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> activities = [
      {
        'name': 'Completed Quiz: Math Basics',
        'date': '2024-08-29',
        'description': 'Scored 85% on the Math Basics quiz.'
      },
      {
        'name': 'Finished Lesson: Introduction to Algebra',
        'date': '2024-08-28',
        'description': 'Completed all sections of the Algebra lesson.'
      },
      {
        'name': 'Earned Certificate: Python Programming',
        'date': '2024-08-25',
        'description': 'Received a certificate for completing the Python Programming course.'
      },
      {
        'name': 'Enrolled in Course: Data Science Fundamentals',
        'date': '2024-08-20',
        'description': 'Started the Data Science Fundamentals course.'
      },
      {
        'name': 'Updated Profile Information',
        'date': '2024-08-18',
        'description': 'Changed profile picture and updated bio.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Activity Log',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return _buildActivityCard(activities[index]);
          },
        ),
      ),
    );
  }

  Widget _buildActivityCard(Map<String, String> activity) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity['name']!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${activity['date']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8),
            Text(
              activity['description']!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
