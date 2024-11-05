import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:llearning/features/Auth/presentation/view/LoginView.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../viewModel/userViewModel.dart';

class ForgetPasswordPage extends ConsumerStatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends ConsumerState<ForgetPasswordPage> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  int currentStep = 0;

  void _sendOTP() async {
    final viewModel = ref.read(authViewModelProvider.notifier);
    await viewModel.sendOtp(_emailController.text);
    final state=ref.watch(authViewModelProvider);
    print(state.message);
    if(state.message =='OTP sent successfully'){
      setState(() {
        currentStep = 1;
      });
    }



  }

  void _validateOTP() async {
    final viewModel = ref.read(authViewModelProvider.notifier);
    await viewModel.verifyOtp(_emailController.text,_otpController.text);
    final state=ref.watch(authViewModelProvider);
    if(state.message=='OTP verified successfully'){
      setState(() {
        currentStep = 2;
      });
    }

  }

  void _changePassword() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      final viewModel = ref.read(authViewModelProvider.notifier);
      await viewModel.ForgetPassword(_emailController.text,_passwordController.text);
      final state=ref.watch(authViewModelProvider);
      if(state.message=='Password updated successfully'){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password Updated Successfully ')),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginView()));
      }
    } else {
      // Handle mismatched passwords
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password', style: TextStyle(color: Colors.deepPurple)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            // App logo
            Center(
              child: Image.asset('assets/icons/appicon.png', height: 100), // Add your app logo
            ),
            SizedBox(height: 40),
            // Step transition animation
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: currentStep == 0
                  ? _buildEmailStep()
                  : currentStep == 1
                  ? _buildOTPStep()
                  : _buildChangePasswordStep(),
            ),
          ],
        ),
      ),
    );
  }

  // Step 1: Email Step
  Widget _buildEmailStep() {
    return Column(
      key: ValueKey(0),
      children: [
        Text(
          "Reset Your Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        SizedBox(height: 16),
        Text(
          "Please enter your registered email address to receive the OTP.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        SizedBox(height: 24),
        // Enhanced Email TextField
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            filled: true,
            fillColor: Colors.deepPurple[50],
            labelStyle: TextStyle(color: Colors.deepPurple),
            hintStyle: TextStyle(color: Colors.deepPurple.shade200),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple.shade100, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 24),
        // Send OTP Button
        ElevatedButton(
          onPressed: _sendOTP,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "Send OTP",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }

  // Step 2: OTP Step with Enhanced Styling
  Widget _buildOTPStep() {
    return Column(
      key: ValueKey(1),
      children: [
        Text(
          "Enter OTP",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        SizedBox(height: 16),
        Text(
          "Check your email for the OTP code and enter it below.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        SizedBox(height: 24),
        // Beautiful OTP Field
        PinCodeTextField(
          appContext: context,
          length: 6,
          controller: _otpController,
          animationType: AnimationType.scale,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(12),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.deepPurple[50],
            selectedFillColor: Colors.deepPurple[100],
            inactiveFillColor: Colors.white,
            activeColor: Colors.deepPurple,
            selectedColor: Colors.deepPurple,
            inactiveColor: Colors.grey,
          ),
          onCompleted: (value) => _validateOTP(),
          onChanged: (value) {},
        ),
        SizedBox(height: 24),
        // Validate OTP Button
        ElevatedButton(
          onPressed: _validateOTP,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "Validate OTP",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }

  // Step 3: Change Password Step
  Widget _buildChangePasswordStep() {
    return Column(
      key: ValueKey(2),
      children: [
        Text(
          "Create New Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        SizedBox(height: 16),
        Text(
          "Set your new password and confirm it.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        SizedBox(height: 24),
        // New Password TextField
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "New Password",
            hintText: "Enter new password",
            filled: true,
            fillColor: Colors.deepPurple[50],
            labelStyle: TextStyle(color: Colors.deepPurple),
            hintStyle: TextStyle(color: Colors.deepPurple.shade200),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple.shade100, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 16),
        // Confirm Password TextField
        TextField(
          controller: _confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Confirm Password",
            hintText: "Confirm new password",
            filled: true,
            fillColor: Colors.deepPurple[50],
            labelStyle: TextStyle(color: Colors.deepPurple),
            hintStyle: TextStyle(color: Colors.deepPurple.shade200),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple.shade100, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 24),
        // Change Password Button
        ElevatedButton(
          onPressed: _changePassword,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "Change Password",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
