import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewPage extends StatefulWidget {
  final String pdfUrl;

  const PDFViewPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PDFViewPage> createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  String? _localFilePath;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _downloadPDF();
  }

  Future<void> _downloadPDF() async {
    final url = "http://10.0.2.2:3000/uploads/pdfs/${widget.pdfUrl}";
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/${widget.pdfUrl}';

    try {
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.stream),
      );

      final file = File(filePath);
      final sink = file.openWrite();  // Create an IOSink for writing

      // Listen to the data stream and write to file
      response.data.stream.listen(
            (data) {
          sink.add(data);  // Write data chunks to file
        },
        onDone: () async {
          await sink.flush();  // Ensure all data is written
          await sink.close();  // Close the file
          setState(() {
            _localFilePath = filePath;
            _isLoading = false;
          });
        },
        onError: (error) {
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        },
        cancelOnError: true,
      );
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('PDF Viewer'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body:  Center(
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: const Color(0xFF1A1A3F),
            rightDotColor: const Color(0xFFEA3799),
            size: 50,
          ),
        )
      );
    }

    if (_hasError) {
      return Scaffold(
        appBar: AppBar(
          title: Text('PDF Viewer'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Center(
          child: Text('Error loading PDF.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _localFilePath != null
          ? PDFView(
        filePath: _localFilePath,
      )
          : Center(child: Text('No PDF file found')),
    );
  }
}
