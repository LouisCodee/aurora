import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/onboarding_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const AuroraApp());
}

class AuroraApp extends StatelessWidget {
  const AuroraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aurora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050A18),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF00F2FF),
          secondary: const Color(0xFF00F2FF),
          surface: const Color(0xFF0D1B2A),
          onSurface: Colors.white,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          displayMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: Colors.white70),
          bodyMedium: TextStyle(color: Colors.white60),
        ),
      ),
      home: const OnboardingScreen(),
      routes: {
        '/onboarding': (ctx) => const OnboardingScreen(),
        '/sign-in': (ctx) => const SignInScreen(),
        '/dashboard': (ctx) => const DashboardScreen(),
        '/add-task': (ctx) => const AddTaskScreen(),
        '/calendar': (ctx) => const CalendarScreen(),
        '/analytics': (ctx) => const AnalyticsScreen(),
        '/settings': (ctx) => const SettingsScreen(),
      },
    );
  }
}
