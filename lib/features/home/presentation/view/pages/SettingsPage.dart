import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Auth/presentation/view/ChangePasswordScreen.dart';
import 'package:llearning/features/Auth/presentation/view/LoginView.dart';
import 'package:llearning/features/Settings/presentation/view/AboutUs.dart';
import 'package:llearning/features/profile/presentation/view/SecurityPage.dart';
import '../../../../../cores/shared_pref/user_shared_pref.dart';
import '../../../../Settings/presentation/view/ContactUsPage.dart';
import '../../../../Settings/presentation/view/PrivacyPolicyPage.dart';
import '../../../../profile/presentation/view/NotificationsPage.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final userPrefs = ref.read(userSharedPrefsProvider);
    await userPrefs.deleteUserToken();


    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            const SizedBox(height: 20),
            _buildCard(
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Toggle dark mode for better night-time reading'),
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
                  leading: const Icon(Icons.language, color: Colors.purple),
                  title: const Text('Language'),
                  subtitle: const Text('Select your preferred language'),
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
            const SizedBox(height: 16.0),
            _buildCard(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.purple),
                  title: const Text('Notifications'),
                  subtitle: const Text('Manage notifications for Courses and grades'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage()));
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: const Icon(Icons.lock, color: Colors.purple),
                  title: const Text('Change Password'),
                  subtitle: const Text('Update your account password'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: const Icon(Icons.privacy_tip, color: Colors.purple),
                  title: const Text('Privacy'),
                  subtitle: const Text('Review and update privacy settings'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyPage()));
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: const Icon(Icons.security, color: Colors.purple),
                  title: const Text('Security'),
                  subtitle: const Text('Manage security settings'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SecurityPage()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            _buildCard(
              children: [
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.purple),
                  title: const Text('About Us'),
                  subtitle: const Text('Learn more about our platform'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: const Icon(Icons.contact_mail, color: Colors.purple),
                  title: const Text('Contact Us'),
                  subtitle: const Text('Reach out to support for help'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage()));
                  },
                ),
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.red),
                  title: const Text('Logout'),
                  subtitle: const Text('Sign out of your account'),
                  onTap: () {
                    _handleLogout(context, ref); // Handle logout action
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
