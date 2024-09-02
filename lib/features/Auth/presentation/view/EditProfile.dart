import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/Entity/UserEntity.dart';
import '../viewModel/userViewModel.dart';

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

      final viewModel = ref.read(authViewModelProvider.notifier);

      final result = await viewModel.updateUserDetails(user);

    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(authViewModelProvider);
    final userDetail = userState.user;

    if (userDetail == null) {
      return const Center(child: CircularProgressIndicator());
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
