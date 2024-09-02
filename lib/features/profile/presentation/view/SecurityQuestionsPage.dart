import 'package:flutter/material.dart';

class SecurityQuestionsPage extends StatefulWidget {
  const SecurityQuestionsPage({Key? key}) : super(key: key);

  @override
  _SecurityQuestionsPageState createState() => _SecurityQuestionsPageState();
}

class _SecurityQuestionsPageState extends State<SecurityQuestionsPage> {
  String? _selectedQuestion1;
  String? _selectedQuestion2;
  String? _selectedQuestion3;

  final TextEditingController _answerController1 = TextEditingController();
  final TextEditingController _answerController2 = TextEditingController();
  final TextEditingController _answerController3 = TextEditingController();

  final List<String> _questions = [
    'What was your childhood nickname?',
    'What is the name of your first pet?',
    'What is your mother’s maiden name?',
    'What was the name of your first school?',
    'What is your favorite movie?',
    'What is your favorite book?',
    'What was the make of your first car?',
    'What city were you born in?',
    'What was the name of your first teacher?',
    'What was the name of your best friend in high school?',
  ];

  @override
  void dispose() {
    _answerController1.dispose();
    _answerController2.dispose();
    _answerController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Security Questions',
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
        child: ListView(
          children: [
            Text(
              'Set Up Security Questions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: 20),
            _buildQuestionCard(
              question: 'Security Question 1',
              selectedQuestion: _selectedQuestion1,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedQuestion1 = newValue;
                });
              },
              controller: _answerController1,
            ),
            SizedBox(height: 16),
            _buildQuestionCard(
              question: 'Security Question 2',
              selectedQuestion: _selectedQuestion2,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedQuestion2 = newValue;
                });
              },
              controller: _answerController2,
            ),
            SizedBox(height: 16),
            _buildQuestionCard(
              question: 'Security Question 3',
              selectedQuestion: _selectedQuestion3,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedQuestion3 = newValue;
                });
              },
              controller: _answerController3,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Handle saving security questions and answers
              },
              child: Text('Save Security Questions'),
              style: ElevatedButton.styleFrom(
               backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard({
    required String question,
    required String? selectedQuestion,
    required ValueChanged<String?> onChanged,
    required TextEditingController controller,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedQuestion,
              onChanged: onChanged,
              isExpanded: true,
              hint: Text('Select a question'),
              items: _questions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Your Answer',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: true, // Keeps answers secure
            ),
          ],
        ),
      ),
    );
  }
}
