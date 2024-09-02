import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'Course Update: Data Science Fundamentals',
        'date': '2024-09-01',
        'description': 'New module on Machine Learning added to your course.'
      },
      {
        'title': 'Reminder: Upcoming Quiz',
        'date': '2024-08-31',
        'description': 'Don’t forget to complete the Math Basics quiz by tomorrow.'
      },
      {
        'title': 'Profile Update Successful',
        'date': '2024-08-30',
        'description': 'Your profile information has been successfully updated.'
      },
      {
        'title': 'New Course Available: Web Development',
        'date': '2024-08-28',
        'description': 'Learn the latest web technologies in the new Web Development course.'
      },
      {
        'title': 'Congratulations on Completing Python Programming',
        'date': '2024-08-25',
        'description': 'You have successfully completed the Python Programming course.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
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
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return _buildNotificationCard(notifications[index]);
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, String> notification) {
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
              notification['title']!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${notification['date']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8),
            Text(
              notification['description']!,
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
