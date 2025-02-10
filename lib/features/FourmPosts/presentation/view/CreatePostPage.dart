import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../viewmodel/postViewModel.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  final String? profile;

  const CreatePostPage({Key? key,  this.profile}) : super(key: key);
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}


class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  List<String> selectedTags = [];


  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _createPost() async {
    final content = _contentController.text;
    final title = _titleController.text; // Get the title text

    if (title.isNotEmpty && content.isNotEmpty) {
      final viewModel = ref.read(postViewModelProvider.notifier);
      await viewModel.createPost(title, content, selectedTags); // Pass title to the createPost method
      final state = ref.read(postViewModelProvider);

        _showPostCreatedDialog();
        _contentController.clear();
        _titleController.clear();
        selectedTags.clear();

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(title.isEmpty ? 'Please enter a title' : 'Please enter content')),
      );
    }
  }

  void _showPostCreatedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/success.json',
                width: 150,
                height: 150,
                repeat: false,
              ),
              const SizedBox(height: 20),
              const Text(
                'Post Created!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your post has been successfully created.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.deepPurpleAccent)),
            ),
          ],
        );
      },
    );
  }

  void _selectTags() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Tags"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._buildTagOptions(),
                _buildTagInput(),
            
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Done', style: TextStyle(color: Colors.deepPurpleAccent)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTagInput() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        controller: _tagController,
        decoration: InputDecoration(
          hintText: 'Add custom tag...',
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: const Icon(Icons.add, color: Colors.deepPurpleAccent),
            onPressed: () {
              _addCustomTag(); // Add custom tag on icon button press
            },
          ),
        ),
        onSubmitted: (tag) {
          _addCustomTag(); // Add the custom tag when the user submits
        },
      ),
    );
  }


  List<Widget> _buildTagOptions() {
    final tags = ['Flutter', 'Dart', 'Tech', 'Programming', 'AI', 'Mobile'];
    return tags.map((tag) {
      return CheckboxListTile(
        title: Text(tag),
        value: selectedTags.contains(tag),
        onChanged: (bool? value) {
          setState(() {
            if (value == true) {
              selectedTags.add(tag);
            } else {
              selectedTags.remove(tag);
            }
          });
        },
      );
    }).toList();
  }
  void _addCustomTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !selectedTags.contains(tag)) {
      setState(() {
        selectedTags.add(tag);
        _tagController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider("http://10.0.2.2:3000/profile/${widget.profile}"),
                    radius: 22, // Increased radius for a more noticeable profile picture
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'What\'s on your mind?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _titleController, // Title input field
              decoration: const InputDecoration(
                hintText: 'Enter post title...',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Write something...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const Divider(thickness: 1),
            Wrap(
              spacing: 8.0,
              children: selectedTags.map((tag) {
                return Chip(
                  label: Text(tag),
                  deleteIcon: const Icon(Icons.clear),
                  onDeleted: () {
                    setState(() {
                      selectedTags.remove(tag);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPostOption(Icons.photo, 'Photo/Video'),
                _buildPostOption(Icons.tag, 'Tag Friends'),
                IconButton(
                  icon: const Icon(Icons.label, color: Colors.blue),
                  onPressed: _selectTags,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: _createPost,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostOption(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        // Add functionality for each option like image picker
      },
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
