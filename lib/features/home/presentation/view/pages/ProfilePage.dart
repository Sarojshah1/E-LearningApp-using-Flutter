import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:llearning/features/Courses/domain/usecases/course_usecase.dart';
import 'package:llearning/features/profile/presentation/view/CertificatesPage.dart';
import 'package:llearning/features/profile/presentation/view/QuizResultsPage.dart';

import '../../../../Auth/presentation/view/EditProfile.dart';
import '../../../../Auth/presentation/viewModel/userViewModel.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  File? _profileImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.read(authViewModelProvider.notifier).getUsers());
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
      final viewModel = ref.read(authViewModelProvider.notifier);
      await viewModel.updateProfilePicture(_profileImage);
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authViewModelProvider);
    final userdetail = user.user;

    if (userdetail == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.person, color: Colors.white),
            const Spacer(),
            const Text('Profile'),
            const Spacer(),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage()));
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double avatarRadius = constraints.maxWidth < 600 ? 80 : 100;
          double iconSize = constraints.maxWidth < 600 ? 24 : 28;
          double fontSizeTitle = constraints.maxWidth < 600 ? 22 : 26;
          double fontSizeSubtitle = constraints.maxWidth < 600 ? 16 : 18;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : userdetail?.profilePicture != null
                              ? CachedNetworkImageProvider("http://10.0.2.2:3000/profile/${userdetail!.profilePicture}")
                              : const AssetImage('assets/icons/appicon.png') as ImageProvider,
                          child: _profileImage == null && userdetail?.profilePicture == null
                              ? Icon(Icons.person, size: avatarRadius, color: Colors.grey.shade800)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: GestureDetector(
                            onTap: _showImagePickerOptions,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: iconSize,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      userdetail?.name ?? '',
                      style: TextStyle(
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      userdetail?.email ?? '',
                      style: TextStyle(
                        fontSize: fontSizeSubtitle,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      userdetail?.bio ?? 'No bio available',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSizeSubtitle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ProfileSection(
                    title: 'Quizzes Results',
                    icon: Icons.assignment_turned_in,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizResultsPage(quizResults: userdetail.quizResults)));
                    },
                    fontSize: fontSizeSubtitle,
                    iconSize: iconSize,
                  ),
                  ProfileSection(
                    title: 'Certificates',
                    icon: Icons.card_membership,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CertificatesPage(certificates: userdetail.certificates)));
                    },
                    fontSize: fontSizeSubtitle,
                    iconSize: iconSize,
                  ),
                 

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final double fontSize;
  final double iconSize;

  const ProfileSection({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.fontSize,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurpleAccent, size: iconSize),
        title: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: iconSize - 4),
        onTap: onTap,
      ),
    );
  }
}
