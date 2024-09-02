import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'CertificateDetailsPage.dart';

class CertificateCard extends StatefulWidget {
  final String badge;
  final String title;
  final DateTime issuedDate;
  final String description;

  const CertificateCard({
    Key? key,
    required this.badge,
    required this.title,
    required this.issuedDate,
    required this.description,
  }) : super(key: key);

  @override
  _CertificateCardState createState() => _CertificateCardState();
}

class _CertificateCardState extends State<CertificateCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Format the issued date
    String formattedDate = DateFormat('MMM d, yyyy').format(widget.issuedDate);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CertificateDetailsPage(
              badge: widget.badge,
              title: widget.title,
              issuedDate: widget.issuedDate,
              description: widget.description,
            ),
          ),
        );
      },
      child: Card(

        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    'http://10.0.2.2:3000/certificate/${widget.badge}',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Issued Date: $formattedDate',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
