import 'package:flutter/material.dart';
import 'package:llearning/features/home/data/models/certificate_model.dart';
import 'CertificateCard.dart';

class CertificatesPage extends StatelessWidget {
  final List<CertificateModel> certificates; // Define your Certificate model or use a dynamic type if needed

  const CertificatesPage({
    Key? key,
    required this.certificates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificates'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Adjust based on your layout needs
            childAspectRatio: 3, // Adjust to control card aspect ratio
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: certificates.length,
          itemBuilder: (context, index) {
            final certificate = certificates[index];
            return CertificateCard(
              badge: certificate.certificate,
              title: certificate.courseId.title,
              issuedDate: certificate.issuedAt,
              description: certificate.courseId.description,

            );
          },
        ),
      ),
    );
  }
}
