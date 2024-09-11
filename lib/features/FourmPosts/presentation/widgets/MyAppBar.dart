import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../Auth/presentation/viewModel/userViewModel.dart';
import '../../../StudyGroups/presentation/view/studyGroupsPage.dart';

// State provider for managing user profile image (example usage)
final profileImageProvider = StateProvider<String>((ref) => 'assets/icons/profile_picture.png');

class MyAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final VoidCallback onCreatePost;

  MyAppBar({required this.onCreatePost});

  @override
  ConsumerState<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends ConsumerState<MyAppBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(authViewModelProvider.notifier).getUsers());
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authViewModelProvider);
    final userdetail = user.user;

    if (user.isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: const Color(0xFF1A1A3F),
            rightDotColor: const Color(0xFFEA3799),
            size: 50,
          ),
        ),
      );
    }

    return AppBar(
      backgroundColor: Colors.deepPurple.shade200,
      elevation: 6.0, // Slightly increased elevation for more prominence
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider("http://10.0.2.2:3000/profile/${userdetail!.profilePicture}"),
          radius: 22, // Increased radius for a more noticeable profile picture
        ),
      ),
      title: GestureDetector(
        onTap: widget.onCreatePost,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.add_circle_outline, color: Colors.deepPurple, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'What\'s on your mind, ${userdetail.name}?',
                  style: GoogleFonts.acme(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'group_chats') {
              // Navigate to Group Chats screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudyGroupPage()), // Replace with actual screen
              );
            } else if (value == 'group_projects') {
              // Navigate to Group Projects screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroupProjectsScreen()), // Replace with actual screen
              );
            }
          },
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 28, // Larger icon for better visibility
          ),
          color: Colors.white, // Background color for the popup menu
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'group_chats',
                child: Row(
                  children: [
                    Icon(Icons.chat_bubble_outline, color: Colors.deepPurple),
                    SizedBox(width: 10),
                    Text(
                      'Group Chats',
                      style: TextStyle(
                        color: Colors.deepPurple.shade800,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'group_projects',
                child: Row(
                  children: [
                    Icon(Icons.assignment_outlined, color: Colors.deepPurple),
                    SizedBox(width: 10),
                    Text(
                      'Group Projects',
                      style: TextStyle(
                        color: Colors.deepPurple.shade800,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
        ),
      ],

      centerTitle: false,
    );
  }
}


class GroupProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Projects'),
      ),
      body: Center(
        child: Text('This is the Group Projects screen'),
      ),
    );
  }
}
