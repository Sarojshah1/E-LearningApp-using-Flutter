import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Auth/presentation/view/ChangePasswordScreen.dart';
import 'package:llearning/features/Auth/presentation/view/LoginView.dart';
import 'package:llearning/features/Settings/presentation/view/AboutUs.dart';
import 'package:llearning/features/profile/presentation/view/SecurityPage.dart';
import '../../../../../App/app.dart';
import '../../../../../cores/shared_pref/app_shared_pref.dart';
import '../../../../../cores/shared_pref/user_shared_pref.dart';
import '../../../../Settings/presentation/view/ContactUsPage.dart';
import '../../../../Settings/presentation/view/PrivacyPolicyPage.dart';
import '../../../../profile/presentation/view/NotificationsPage.dart';
final AppSharedPrefsProvider = Provider<AppSharedPrefs>((ref) {
  return AppSharedPrefs();
});
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    darkmode();

  }
  Future<void> darkmode() async{
    final appSharedPrefs = ref.read(AppSharedPrefsProvider);
    final result = await appSharedPrefs.getDarkMode();
    result.fold(
          (failure) {
        // Handle failure case here if needed
      },
          (isDarkMode) {
        setState(() {
          _isDarkMode=isDarkMode ?? false;
        });

      },
    );
  }
  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      _handleLogout(context, ref);
    }
  }


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
    final themeNotifier = ref.watch(themeNotifierProvider);
    bool isDarkMode = themeNotifier.isDarkMode;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Settings', style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold)),
      //   centerTitle: true,
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Colors.purple, Colors.indigo],
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomRight,
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            _buildCard(
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Toggle dark mode for better night-time reading'),
                  value: _isDarkMode,
                  onChanged: (bool value) async{
                    final appSharedPrefs = ref.read(AppSharedPrefsProvider);
                    if(_isDarkMode==true){
                      final result = await appSharedPrefs.setDarkMode(false);
                    }else{
                      final result = await appSharedPrefs.setDarkMode(true);
                    }
                    setState(() {
                      _isDarkMode = value;
                      themeNotifier.toggleTheme(value);

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
                    _confirmLogout(); // Handle logout action
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
