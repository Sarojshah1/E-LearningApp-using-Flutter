import 'package:flutter/material.dart';
import 'package:llearning/App/constants/formatdate.dart';


class CertificateDetailsPage extends StatelessWidget {
  final String badge;
  final String title;
  final DateTime issuedDate;
  final String description;

  const CertificateDetailsPage({
    Key? key,
    required this.badge,
    required this.title,
    required this.issuedDate,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = FormatDate.formatDateOnly(issuedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'http://10.0.2.2:3000/certificate/$badge',
                      width: 180,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    'Issued Date: $formattedDate',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Certificate Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black87,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
