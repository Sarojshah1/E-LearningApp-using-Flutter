import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import '../../domain/Entity/UserEntity.dart';
import '../viewModel/userViewModel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _bio;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(authViewModelProvider.notifier).getUsers());
  }
  Future<void> changeDetails()async{
    if (_formKey.currentState!.validate()) {
      print(_name);
      final user = UserEntity(
        name: _name!,
        email: _email!,
        password: '',
        bio: _bio!,
        role: 'student', // Set the role as required
      );

      final viewModel = await ref.read(authViewModelProvider.notifier).updateUserDetails(user);

      if(viewModel){
        _showProfileUpdatedDialog();

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile!')),
        );
      }


    }
  }
  void _showProfileUpdatedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[200],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/updated.json',
                width: 300,
                height: 200,
                repeat: false,
              ),
              const SizedBox(height: 20),
              const Text(
                'Profile Updated!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your profile details have been successfully updated.',
                textAlign: TextAlign.center,
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

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(authViewModelProvider);
    final userDetail = userState.user;

    if (userDetail == null) {
      return Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color(0xFF1A1A3F),
          rightDotColor: const Color(0xFFEA3799),
          size: 50,
        ),
      );
    }

    _name ??= userDetail.name;
    _email ??= userDetail.email;
    _bio ??= userDetail.bio;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Edit Profile')),
        backgroundColor: Colors.deepPurpleAccent,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: userDetail.profilePicture != null
                        ? CachedNetworkImageProvider(
                        "http://10.0.2.2:3000/profile/${userDetail.profilePicture}")
                        : const AssetImage('assets/icons/appicon.png') as ImageProvider,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  initialValue: _name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: const Icon(Icons.person, color: Colors.deepPurpleAccent),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) => _name = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: _email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email, color: Colors.deepPurpleAccent),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value) => _email = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: _bio,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    prefixIcon: const Icon(Icons.info, color: Colors.deepPurpleAccent),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  onChanged: (value) => _bio = value,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.deepPurpleAccent,
                    shadowColor: Colors.black.withOpacity(0.2),
                    elevation: 5,
                  ),
                  onPressed: changeDetails,
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
