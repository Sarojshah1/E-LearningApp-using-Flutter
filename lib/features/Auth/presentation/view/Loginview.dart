import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Auth/presentation/view/SignUpView.dart';
import '../../../../App/app.dart';
import '../../../../cores/failure/failure.dart';
import '../../../../cores/shared_pref/user_shared_pref.dart';
import '../../../home/presentation/view/HomeView.dart';
import '../viewModel/userViewModel.dart';
import 'forget_password_page.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class LoginView extends ConsumerStatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();  // Form key for validation

  bool _rememberMe = false;
  bool _obscureText = true;  // Password visibility toggle
  bool _isLoading = false;   // Loading state

  @override
  Widget build(BuildContext context) {
    final authViewModel = ref.watch(authViewModelProvider.notifier);
    final themeNotifier = ref.watch(themeNotifierProvider);
    bool isDarkMode = themeNotifier.isDarkMode;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color:isDarkMode ? Colors.black: Colors.white, // Simple white background
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey, // Attach form key for validation
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start, // Align to left
                      children: [
                        // App Logo
                        Center(child: Image.asset('assets/icons/appicon.png')),
                        SizedBox(height: 40),
                        // Title
                        Text(
                          "Let’s Sign In.!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color:isDarkMode ? Colors.white: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Login to Your Account to Continue your Courses",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            color:isDarkMode ? Colors.white: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 30),
                        // Email Field with Validator
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            filled: true,
                            fillColor:isDarkMode ? Colors.white54: Colors.grey.shade200,
                            prefixIcon: Icon(Icons.email, color: isDarkMode ? Colors.black38:Colors.grey.shade600),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Password Field with Toggle Visibility
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: "Password",
                            filled: true,
                            fillColor:isDarkMode ? Colors.white54: Colors.grey.shade200,
                            prefixIcon: Icon(Icons.lock, color:isDarkMode ? Colors.black38: Colors.grey.shade600),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey.shade600,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        // Remember Me and Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value!;
                                    });
                                  },
                                ),
                                Text("Remember Me"),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordPage()));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Login Button with Arrow
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });

                                final email = _emailController.text;
                                final password = _passwordController.text;

                                await authViewModel.userLogin(email, password);
                                final userSharedPrefs = ref.read(userSharedPrefsProvider);
                                final token = await userSharedPrefs.getUserToken();
                                final authtoken = token.fold((l) => throw Failure(error: l.error), (r) => r);

                                setState(() {
                                  _isLoading = false;
                                });

                                if (authtoken != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Login successful!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HomeView()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Login failed: ${ref.read(authViewModelProvider).error}'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            icon: Text(
                              "Sign In",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            label: SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white, // Background color
                                  shape: BoxShape.circle, // Rounded container
                                ),
                                padding: const EdgeInsets.all(8.0), // Padding inside the circle
                                child: Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Colors.blue, // Icon color
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 90,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Social Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.facebook, color: Colors.blue, size: 50),
                              onPressed: () {
                                // Handle Facebook Login
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Sign Up Option
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Don’t have an account? ",
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context) => SignupView()));
                                      // Handle Sign Up
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Beautiful Loading Overlay
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3), // Slightly less opaque
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Loading...",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
