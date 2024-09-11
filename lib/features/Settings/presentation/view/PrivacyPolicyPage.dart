import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this for email link functionality

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool _showMoreIntro = false;
  bool _showMoreDataCollection = false;
  bool _showMoreCookies = false;
  bool _showMoreThirdParty = false;
  bool _showMoreRights = false;
  bool _showMoreChanges = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
        toolbarHeight: 90,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/icons/appiconlarge.png',
            height: 90,
            width: 90,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              _buildSection(
                'Introduction',
                'Welcome to SkillWave! Your privacy is our top priority. We are dedicated to safeguarding your personal information and providing a secure learning environment. Our privacy policy outlines how we collect, use, and protect your data, ensuring a transparent and trustworthy experience.',
                _showMoreIntro,
                    () => setState(() => _showMoreIntro = !_showMoreIntro),
              ),
              _buildSection(
                'Data Collection',
                'We collect information from you when you register on our site, subscribe to our newsletter, or use our services. This may include personal details such as your name, email address, and usage data to enhance your experience on our platform.',
                _showMoreDataCollection,
                    () => setState(() => _showMoreDataCollection = !_showMoreDataCollection),
              ),
              _buildSection(
                'Use of Cookies',
                'Cookies are small files that are stored on your device to improve your experience and help us understand how you use our site. They enable us to provide personalized content and track site usage for better functionality.',
                _showMoreCookies,
                    () => setState(() => _showMoreCookies = !_showMoreCookies),
              ),
              _buildSection(
                'Third-Party Services',
                'We may share your information with trusted third-party services to enhance our platform functionality and provide better services. These parties are obligated to protect your data and use it solely for the purposes intended.',
                _showMoreThirdParty,
                    () => setState(() => _showMoreThirdParty = !_showMoreThirdParty),
              ),
              _buildSection(
                'User Rights',
                'You have the right to access, correct, or delete your personal data, and to request a copy of your data. For any such requests, please contact us as specified in the Contact Us section.',
                _showMoreRights,
                    () => setState(() => _showMoreRights = !_showMoreRights),
              ),
              _buildSection(
                'Changes to This Policy',
                'We may update our privacy policy occasionally. The most recent version will always be available on our website. We encourage you to review this policy periodically to stay informed of any changes.',
                _showMoreChanges,
                    () => setState(() => _showMoreChanges = !_showMoreChanges),
              ),
              SizedBox(height: 30),
              _buildContactSection(),
              SizedBox(height: 20),
              _buildSearchSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/appiconlarge.png',
              height: 120,
              width: 120,
            ),
            SizedBox(height: 10),
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, bool showMore, VoidCallback toggleShowMore) {
    final displayContent = showMore ? content : (content.length > 150 ? content.substring(0, 150) + '...' : content);

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
          SizedBox(height: 10),
          Text(
            displayContent,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: toggleShowMore,
            child: Text(
              showMore ? 'Read Less' : 'Read More',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurpleAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'If you have any questions or concerns about this Privacy Policy, feel free to reach out to us:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'privacy@elearningplatform.com',
                queryParameters: {'subject': 'Privacy Policy Inquiry'},
              );
              if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
              } else {
                throw 'Could not launch $emailLaunchUri';
              }
            },
            child: Row(
              children: [
                Icon(Icons.email, color: Colors.deepPurpleAccent, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'privacy@elearningplatform.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Privacy Policy',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search, color: Colors.deepPurpleAccent),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (text) {
              // Implement search functionality here
            },
          ),
        ],
      ),
    );
  }
}
