import 'package:flutter/material.dart';
import 'package:llearning/App/constants/formatdate.dart';
import 'package:llearning/features/blog/data/model/blog_model.dart';

class BlogCard extends StatelessWidget {
  final BlogModel blog;
  final Function(BlogModel blog) onCardTap;

  const BlogCard({
    Key? key,
    required this.blog,
    required this.onCardTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCardTap(blog),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                blog.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Divider with an accent color
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 1,
              color: Colors.deepPurpleAccent.withOpacity(0.2),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author and Date Section
                  Row(
                    children: [
                      const Icon(Icons.person, size: 22, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          blog.userId.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurple[800],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.calendar_today, size: 22, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Text(
                        FormatDate.formatDateOnly(blog.createdAt),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tags Section
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 6.0,
                    children: blog.tags.map((tag) => Chip(
                      label: Text(tag),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurple,
                      ),
                      backgroundColor: Colors.deepPurple.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    )).toList(),
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
