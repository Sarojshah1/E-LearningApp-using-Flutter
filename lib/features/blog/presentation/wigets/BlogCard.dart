import 'package:flutter/material.dart';
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
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        shadowColor: Colors.black45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Created by ${blog.userId.name} on ${blog.createdAt.toLocal().toShortDateString()}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8.0,
                children: blog.tags.map((tag) => Chip(label: Text(tag))).toList(),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String toShortDateString() {
    return "${this.day}/${this.month}/${this.year}";
  }
}
