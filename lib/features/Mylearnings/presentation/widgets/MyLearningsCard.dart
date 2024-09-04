import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:llearning/features/Mylearnings/presentation/view/LessonListPage.dart';
import '../../data/model/mylearningModel.dart';

class MyLearningsCard extends StatefulWidget {
  final EnrollmentModel course;

  const MyLearningsCard({required this.course});

  @override
  _MyLearningsCardState createState() => _MyLearningsCardState();
}

class _MyLearningsCardState extends State<MyLearningsCard> {
  bool isReadMore = false;

  void toggleReadMore() {
    setState(() {
      isReadMore = !isReadMore;
    });
  }

  void handleCardClick() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LessonListPage(courseId: widget.course.courseId.id,)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleCardClick,
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.withOpacity(0.1), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'http://10.0.2.2:3000/thumbnails/${widget.course.courseId.thumbnail}',
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15),
            Text(
              widget.course.courseId.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              isReadMore
                  ? widget.course.courseId.description
                  : '${widget.course.courseId.description.substring(0, 10)}...',
              style: TextStyle(color: Colors.black54),
              maxLines: isReadMore ? null : 3,
              overflow: isReadMore ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: toggleReadMore,
              child: Text(
                isReadMore ? 'Read Less' : 'Read More',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.green,
                  size: 22,
                ),
                SizedBox(width: 10),
                Text(
                  'Progress',
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  width: widget.course.progress.toDouble() * 3, // Adjust multiplier based on progress
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '${widget.course.progress}% Complete',
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.chalkboardTeacher,
                  color: Colors.blue,
                  size: 22,
                ),
                SizedBox(width: 10),
                Text(
                  'Total Lessons: ${widget.course.courseId.lessons.length}',
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
