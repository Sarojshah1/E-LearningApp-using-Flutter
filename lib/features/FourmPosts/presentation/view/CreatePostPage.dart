import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/FourmPosts/presentation/viewmodel/postViewModel.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _createPost() async{
    final title = _titleController.text;
    final content = _contentController.text;
    final tags = _tagsController.text.split(',').map((tag) => tag.trim()).toList();

    if (title.isNotEmpty && content.isNotEmpty && tags.isNotEmpty) {
      // Placeholder for post creation logic
      print('Title: $title');
      print('Content: $content');
      print('Tags: $tags');
      final viewModel=ref.read(postViewModelProvider.notifier);
      await viewModel.createPost(title, content, tags);

      _titleController.clear();
      _contentController.clear();
      _tagsController.clear();

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a New Post',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: _titleController,
                labelText: 'Title',
                icon: Icons.title,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: _contentController,
                labelText: 'Content',
                icon: Icons.description,
                maxLines: 5,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: _tagsController,
                labelText: 'Tags (comma separated)',
                icon: Icons.tag,
              ),
              SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: _createPost,
                  style: ElevatedButton.styleFrom(

                      backgroundColor: Colors.deepPurpleAccent, // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    elevation: 5,
                  ),
                  child: Text(
                    'Create Post',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 4),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.deepPurpleAccent),
          prefixIcon: Icon(icon, color: Colors.deepPurpleAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
