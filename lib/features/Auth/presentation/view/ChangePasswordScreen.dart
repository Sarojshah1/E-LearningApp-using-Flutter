import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewModel/userViewModel.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  void _toggleCurrentPasswordVisibility() {
    setState(() {
      _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
    });
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _isNewPasswordVisible = !_isNewPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _saveChanges() async{
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final viewModel = ref.read(authViewModelProvider.notifier);
      await viewModel.changePassword(_currentPassword,_newPassword);
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
            content: Text("Password successfully changed!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen size and orientation
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Change Password",
            style: TextStyle(
              fontSize: screenWidth * 0.05, // Responsive font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPasswordField(
                label: "Current Password",
                obscureText: !_isCurrentPasswordVisible,
                toggleVisibility: _toggleCurrentPasswordVisibility,
                isVisible: _isCurrentPasswordVisible,
                onChanged: (value) => _currentPassword = value!,
                validator: (value) => value!.isEmpty ? 'Please enter your current password' : null,
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              _buildPasswordField(
                label: "New Password",
                obscureText: !_isNewPasswordVisible,
                toggleVisibility: _toggleNewPasswordVisibility,
                isVisible: _isNewPasswordVisible,
                onChanged: (value) {
                  _newPassword = value!;
                  setState(() {}); // Update password strength indicator
                },
                validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive spacing
              _buildPasswordStrengthIndicator(),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              _buildPasswordField(
                label: "Confirm Password",
                obscureText: !_isConfirmPasswordVisible,
                toggleVisibility: _toggleConfirmPasswordVisibility,
                isVisible: _isConfirmPasswordVisible,
                onChanged: (value) => _confirmPassword = value!,
                validator: (value) => value != _newPassword ? 'Passwords do not match' : null,
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _saveChanges,
                child: Text("Save Changes",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent, // Button color
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  minimumSize: Size(double.infinity, screenHeight * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required bool obscureText,
    required VoidCallback toggleVisibility,
    required bool isVisible,
    required FormFieldSetter<String> onChanged,
    required FormFieldValidator<String> validator,
  }) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: TextFormField(
        key: ValueKey(label),
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter your $label',
          suffixIcon: IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: toggleVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    Color strengthColor;
    String strengthText;

    if (_newPassword.length < 6) {
      strengthColor = Colors.red;
      strengthText = 'Weak';
    } else if (_newPassword.length < 8) {
      strengthColor = Colors.orange;
      strengthText = 'Moderate';
    } else {
      strengthColor = Colors.green;
      strengthText = 'Strong';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password Strength: $strengthText',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        SizedBox(height: 4.0),
        LinearProgressIndicator(
          value: _newPassword.length / 10,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
        ),
      ],
    );
  }
}
