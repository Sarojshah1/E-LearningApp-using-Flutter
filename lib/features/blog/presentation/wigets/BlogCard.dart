import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Add this import for Riverpod
import 'package:llearning/App/constants/formatdate.dart';
import 'package:llearning/features/blog/data/model/blog_model.dart';

import '../../../../App/app.dart';


class BlogCard extends ConsumerStatefulWidget {
  final BlogModel blog;
  final Function(BlogModel blog) onCardTap;

  const BlogCard({
    Key? key,
    required this.blog,
    required this.onCardTap,
  }) : super(key: key);

  @override
  ConsumerState<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends ConsumerState<BlogCard> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = ref.watch(themeNotifierProvider);
    bool isDarkMode = themeNotifier.isDarkMode;

    return GestureDetector(
      onTap: () => widget.onCardTap(widget.blog),
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
                widget.blog.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:isDarkMode ? Colors.white: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Divider with an accent color
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 1,
              color:isDarkMode ? Colors.white: Colors.deepPurpleAccent.withOpacity(0.2),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author and Date Section
                  Row(
                    children: [
                       Icon(Icons.person, size: 22, color: isDarkMode ? Colors.white:Colors.deepPurple),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.blog.userId.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white:Colors.deepPurple[800],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 16),
                       Icon(Icons.calendar_today, size: 22, color:isDarkMode ? Colors.white: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Text(
                        FormatDate.formatDateOnly(widget.blog.createdAt),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:isDarkMode ? Colors.white: Colors.blueGrey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tags Section
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 6.0,
                    children: widget.blog.tags.map((tag) => Chip(
                      label: Text(tag),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.white:Colors.deepPurple,
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
