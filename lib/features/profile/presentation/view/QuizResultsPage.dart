import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:llearning/features/home/data/models/user_quiz_result_model.dart';

class QuizResultsPage extends StatelessWidget {
  final List<UserQuizResultModel> quizResults;

  const QuizResultsPage({
    Key? key,
    required this.quizResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: quizResults.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.blueGrey[200],
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          final result = quizResults[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: QuizResultCard(result: result),
          );
        },
      ),
    );
  }
}

class QuizResultCard extends StatelessWidget {
  final UserQuizResultModel result;

  const QuizResultCard({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM d, yyyy').format(result.attemptedAt);
    double scorePercentage = result.score.toDouble();  // Assuming score is out of 100

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: scorePercentage >= 50 ? Colors.green[50] : Colors.white,  // Green background for passed quizzes
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.quiz, size: 30, color: Colors.blueAccent),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    result.quizId.title ?? 'No Title',  // Assuming QuizModel has a title
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            _buildScore(context, scorePercentage),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  'Completed on: $formattedDate',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              result.status,  // Displaying status as description
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.green,

              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildScore(BuildContext context, double scorePercentage) {
    return Text(
      '${scorePercentage.toStringAsFixed(1)}%',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: scorePercentage >= 50 ? Colors.green : Colors.red,
      ),
    );
  }
}
