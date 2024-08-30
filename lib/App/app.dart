import 'package:flutter/material.dart';
import 'package:llearning/App/navigator_key/navigator_key.dart';
import 'package:llearning/features/welcomeScreens/presentation/view/splash_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }
}

final themeNotifierProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier();
});
class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      title: 'SkillWave',
      themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const SplashView(),
      navigatorKey: AppNavigator.navigatorKey,
    );
  }
}

