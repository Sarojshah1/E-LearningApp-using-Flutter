import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  final String thumbnail;
  final String title;
  final String description;
  final String price;
  final String duration;
  final String level;
  final String creator;
  final VoidCallback onEnroll;

  const CourseCard({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
    required this.level,
    required this.creator,
    required this.onEnroll,
  }) : super(key: key);

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isReadMore = false;

  void toggleReadMore() {
    setState(() {
      isReadMore = !isReadMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return GestureDetector(
      onTap: widget.onEnroll,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: screenWidth * 0.4, // Responsive height
                  child: Image.network(
                    'http://10.0.2.2:3000/thumbnails/${widget.thumbnail}',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      widget.level,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(mediaQuery.size.width * 0.05), // Responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 24 : 20, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: mediaQuery.size.width * 0.02), // Responsive spacing
                  Text(
                    isReadMore
                        ? widget.description
                        : '${widget.description.length > 50 ? widget.description.substring(0, 50) + '...' : widget.description}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  GestureDetector(
                    onTap: toggleReadMore,
                    child: Text(
                      isReadMore ? 'Read Less' : 'Read More',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: mediaQuery.size.width * 0.02), // Responsive spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey[600]),
                          SizedBox(width: 5),
                          Text(widget.duration),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange),
                          SizedBox(width: 5),
                          Text(widget.level),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.grey[600]),
                          SizedBox(width: 5),
                          Text(widget.creator),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: mediaQuery.size.width * 0.05), // Responsive spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Npr.${widget.price}',
                        style: TextStyle(
                          fontSize: screenWidth > 600 ? 22 : 18, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: widget.onEnroll,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth > 600 ? 20 : 16, // Responsive padding
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          'Enroll Now',
                          style: TextStyle(color: Colors.white, fontSize: screenWidth > 600 ? 16 : 14), // Responsive font size
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
