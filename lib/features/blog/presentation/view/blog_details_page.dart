import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:llearning/App/constants/formatdate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart'; // Import share_plus
import '../../data/model/blog_model.dart';

class BlogDetailPage extends StatefulWidget {
  final BlogModel blog;

  const BlogDetailPage({Key? key, required this.blog}) : super(key: key);

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  String? _localFilePath;
  bool _isLoading = true;
  bool _hasError = false;
  bool _isFavorite = false; // Track favorite status

  @override
  void initState() {
    super.initState();
    _downloadPDF();
  }

  Future<void> _downloadPDF() async {
    final url = "http://10.0.2.2:3000/uploads/pdfs/${widget.blog.content}";
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/${widget.blog.content}';

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

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite; // Toggle favorite status
    });
    // Here you can implement saving the favorite status to a local database if needed
  }

  void _shareBlog() {
    final String shareContent = "Check out this blog: ${widget.blog.title}\n\n"
        "Read more at: http://10.0.2.2:3000/uploads/pdfs/${widget.blog.content}"; // You can customize the content
    Share.share(shareContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog.title, style: const TextStyle(fontSize: 22)),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
        shadowColor: Colors.deepPurpleAccent.withOpacity(0.5),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareBlog,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600; // Adjust this threshold based on your design

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.deepPurpleAccent.withOpacity(0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.blog.title,
                      style: TextStyle(
                        fontSize: isTablet ? 32 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16, color: Colors.black54),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            widget.blog.userId.name,
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                            overflow: TextOverflow.ellipsis, // Truncate if the text is too long
                            maxLines: 1, // Restrict to one line
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            FormatDate.formatDateOnly(widget.blog.createdAt),
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time, size: 16, color: Colors.black54),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '1 hrs read',
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
              const SizedBox(height: 20),
              // PDF Viewer Section
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _hasError
                    ? const Center(child: Text('Error loading PDF'))
                    : PDFView(
                  filePath: _localFilePath,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: false,
                  pageFling: true,
                  pageSnap: true,
                  defaultPage: 0,
                  fitPolicy: FitPolicy.BOTH,

                ),
              ),
            ],
          );
        },
      ),
    );
  }

  int _calculateReadingTime(String content) {
    final words = content.split(' ').length;
    return (words / 200).ceil();
  }
}
