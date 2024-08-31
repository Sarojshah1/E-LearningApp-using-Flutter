import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Auth/presentation/view/Loginview.dart';

import '../../../../cores/shared_pref/app_shared_pref.dart';
import 'OnboardingView.dart';

final AppSharedPrefsProvider = Provider<AppSharedPrefs>((ref) {
  return AppSharedPrefs();
});
class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    changescreen();

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  Future<void> changescreen() async {

    final appSharedPrefs = ref.read(AppSharedPrefsProvider);



    final result = await appSharedPrefs.getFirstTime();
    result.fold(
          (failure) {
      },
          (isFirstTime) {
        // Default to true if isFirstTime is null (in case of uninitialized SharedPreferences)
        final isFirstTimeBool = isFirstTime ?? true;
        Future.delayed(const Duration(seconds: 3), () async{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context){
              return  isFirstTimeBool ? const OnboardingView() : LoginView();
            }),
          );

        });
      },
    );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Background color for splash screen
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Image.asset(
            'assets/images/splash.png',
            width: 400, // Set a specific width to make the image more proportional
            height: 400, // Set a specific height
            fit: BoxFit.contain, // Keeps the aspect ratio
          ),
        ),
      ),
    );
  }
}
