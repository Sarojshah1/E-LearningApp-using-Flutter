import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro Section
            Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: Text(
                'We’re Here to Assist You!',
                style: TextStyle(
                  fontSize: isWide ? size.width * 0.06 : size.width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Text(
              'For any queries, feedback, or support, don’t hesitate to reach out. We are committed to providing the best experience for you.',
              style: TextStyle(
                fontSize: isWide ? size.width * 0.04 : size.width * 0.05,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: size.height * 0.03),

            // Contact Form
            Container(
              padding: EdgeInsets.all(size.width * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drop Us a Message',
                    style: TextStyle(
                      fontSize: isWide ? size.width * 0.05 : size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Your Message',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      // Handle form submission
                    },
                    child: Text('Send Message'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.1),
                      textStyle: TextStyle(fontSize: size.width * 0.05),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),

            // Support Section
            Container(
              padding: EdgeInsets.all(size.width * 0.05),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Support',
                    style: TextStyle(
                      fontSize: isWide ? size.width * 0.05 : size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'For any technical issues or account-related questions, please reach out to our support team:',
                    style: TextStyle(
                      fontSize: isWide ? size.width * 0.04 : size.width * 0.05,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.blueAccent),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        'support@skillwave.com',
                        style: TextStyle(
                          fontSize: isWide ? size.width * 0.045 : size.width * 0.05,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blueAccent),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        '+1 (123) 456-7890',
                        style: TextStyle(
                          fontSize: isWide ? size.width * 0.045 : size.width * 0.05,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),

            // Feedback Section
            Container(
              padding: EdgeInsets.all(size.width * 0.05),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We Value Your Feedback',
                    style: TextStyle(
                      fontSize: isWide ? size.width * 0.05 : size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Help us improve by sharing your thoughts and suggestions:',
                    style: TextStyle(
                      fontSize: isWide ? size.width * 0.04 : size.width * 0.05,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Your Feedback',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      // Handle feedback submission
                    },
                    child: Text('Submit Feedback'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.1),
                      textStyle: TextStyle(fontSize: size.width * 0.05),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),

            // General Inquiry Section
            Container(
              padding: EdgeInsets.all(size.width * 0.05),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'General Inquiries',
                    style: TextStyle(
                      fontSize: isWide ? size.width * 0.05 : size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'For general questions or information about our services, please contact us at:',
                    style: TextStyle(
                      fontSize: isWide ? size.width * 0.04 : size.width * 0.05,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.blueAccent),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        'info@skillwave.com',
                        style: TextStyle(
                          fontSize: isWide ? size.width * 0.045 : size.width * 0.05,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blueAccent),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        '+1 (123) 456-7890',
                        style: TextStyle(
                          fontSize: isWide ? size.width * 0.045 : size.width * 0.05,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
