import 'package:flutter/material.dart';
import 'package:llearning/features/Auth/presentation/view/ChangePasswordScreen.dart';
import 'package:llearning/features/profile/presentation/view/SecurityQuestionsPage.dart';
import 'package:llearning/features/profile/presentation/view/ViewActivityPage.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _isTwoFactorAuthEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Security Settings',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Enhance Your Account Security',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: 20),
            _buildCard(
              title: 'Two-Factor Authentication',
              icon: Icons.verified_user,
              subtitle:
              'Add an extra layer of security to your account by enabling two-factor authentication.',
              toggle: Switch(
                value: _isTwoFactorAuthEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isTwoFactorAuthEnabled = value;
                    // Handle two-factor authentication toggle here
                  });
                },
              ),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: 'Change Password',
              icon: Icons.lock,
              subtitle:
              'Ensure your account is secure by regularly updating your password.',
              action: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen()));
                },
                child: Text('Change Password'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: 'Security Questions',
              icon: Icons.security,
              subtitle:
              'Set up security questions to help recover your account if you forget your password.',
              action: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const SecurityQuestionsPage()));
                },
                child: Text('Set Up Questions'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: 'Account Activity',
              icon: Icons.history,
              subtitle:
              'Review your recent account activity for any suspicious behavior.',
              action: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewActivityPage()));
                },
                child: Text('View Activity'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required String subtitle,
    Widget? toggle,
    Widget? action,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.teal),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            if (toggle != null) toggle,
            if (action != null) action,
          ],
        ),
      ),
    );
  }
}
