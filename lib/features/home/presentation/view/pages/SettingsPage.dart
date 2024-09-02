import 'package:flutter/material.dart';
import 'package:llearning/features/Auth/presentation/view/ChangePasswordScreen.dart';
import 'package:llearning/features/Settings/presentation/view/AboutUs.dart';
import 'package:llearning/features/profile/presentation/view/SecurityPage.dart';
import '../../../../Settings/presentation/view/ContactUsPage.dart';
import '../../../../profile/presentation/view/NotificationsPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          children: [
            Text(
              'Manage Your Learning Experience',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: 20),
            _buildCard(
              children: [
                SwitchListTile(
                  title: Text('Dark Mode'),
                  subtitle: Text('Toggle dark mode for better night-time reading'),
                  value: _isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      _isDarkMode = value;
                      // Handle dark mode toggle here
                    });
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: Icon(Icons.language, color: Colors.teal),
                  title: Text('Language'),
                  subtitle: Text('Select your preferred language'),
                  trailing: DropdownButton<String>(
                    value: _selectedLanguage,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLanguage = newValue!;
                        // Handle language change logic here
                      });
                    },
                    items: <String>['English', 'Spanish', 'French', 'German']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            _buildCard(
              children: [
                ListTile(
                  leading: Icon(Icons.notifications, color: Colors.teal),
                  title: Text('Notifications'),
                  subtitle: Text('Manage notifications for Courses and grades'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationsPage()));
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: Icon(Icons.lock, color: Colors.teal),
                  title: Text('Change Password'),
                  subtitle: Text('Update your account password'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: Icon(Icons.privacy_tip, color: Colors.teal),
                  title: Text('Privacy'),
                  subtitle: Text('Review and update privacy settings'),
                  onTap: () {
                    // Navigate to privacy settings page
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: Icon(Icons.security, color: Colors.teal),
                  title: Text('Security'),
                  subtitle: Text('Manage security settings'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SecurityPage()));
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            _buildCard(
              children: [
                ListTile(
                  leading: Icon(Icons.info, color: Colors.teal),
                  title: Text('About Us'),
                  subtitle: Text('Learn more about our platform'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: Icon(Icons.contact_mail, color: Colors.teal),
                  title: Text('Contact Us'),
                  subtitle: Text('Reach out to support for help'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage()));
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.red),
                  title: Text('Logout'),
                  subtitle: Text('Sign out of your account'),
                  onTap: () {
                    // Handle logout action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Column(
        children: children,
      ),
    );
  }
}
