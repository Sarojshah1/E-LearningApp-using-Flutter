import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Auth/presentation/view/Loginview.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboarding1.png",
      "title": "Start Your Journey Today",
      "description": "Begin your educational adventure with SkillWave, where every lesson counts."
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Empower Your Education Journey",
      "description": "Strengthen your knowledge with interactive lessons designed for your success."
    },
    {
      "image": "assets/images/onboarding3.png",
      "title": "Explore Endless Possibilities",
      "description": "Unlock new skills and potential with comprehensive quizzes and assessments."
    },
    {
      "image": "assets/images/onboarding4.png",
      "title": "Step into a World of Learning Excellence",
      "description": "Achieve your goals with a personalized learning experience and progress tracking."
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: onboardingData.length,
            itemBuilder: (context, index) => OnboardingSlide(
              image: onboardingData[index]["image"]!,
              title: onboardingData[index]["title"]!,
              description: onboardingData[index]["description"]!,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
          ),
          Positioned(
            top: screenHeight * 0.05, // Responsive positioning
            right: screenWidth * 0.05,
            child: TextButton(
              onPressed: () {
                _pageController.jumpToPage(onboardingData.length - 1);
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.05, // Responsive positioning
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    onboardingData.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8,
                      width: _currentPage == index ? 20 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.blueAccent
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_currentPage == onboardingData.length - 1) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginView()));
                      // Navigate to the main screen or home screen
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  label: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      shape: BoxShape.circle, // Makes the container rounded

                    ),
                    padding: const EdgeInsets.all(8.0), // Padding inside the circle
                    child: Icon(
                      _currentPage == onboardingData.length - 1
                          ? Icons.arrow_forward_outlined
                          : Icons.arrow_forward,
                      color: Colors.blue, // Icon color
                    ),
                  ),
                  icon: Text(
                    _currentPage == onboardingData.length - 1 ? "Continue" : "Next",
                    style: const TextStyle(color: Colors.white,fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
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
}

class OnboardingSlide extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double screenWidth;
  final double screenHeight;

  const OnboardingSlide({
    required this.image,
    required this.title,
    required this.description,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.1, // Responsive padding
        vertical: screenHeight * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: screenHeight * 0.4, // Responsive image height
            fit: BoxFit.contain,
          ),
          SizedBox(height: screenHeight * 0.05), // Responsive spacing
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.08, // Responsive font size
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // Responsive spacing
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.045, // Responsive font size
              color: Colors.grey,
              height: 1.5,
              fontFamily: 'OpenSans',
            ),
          ),
        ],
      ),
    );
  }
}
