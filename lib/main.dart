import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';
import 'core/theme.dart';
import 'features/tasks/presentation/bloc/tasks_bloc.dart';

import 'features/splash/presentation/pages/splash_page.dart';
import 'features/register/presentation/pages/register_page.dart';

import 'screens/main_shell.dart';
import 'screens/add_task_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Boot dependency injection (reads SharedPreferences, registers all deps)
  await initDependencies();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<TasksBloc>(create: (_) => sl<TasksBloc>()..add(LoadTasks())),
      ],
      child: MaterialApp(
        title: 'Aurora',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AuroraColors.background,
          colorScheme: ColorScheme.dark(
            primary: AuroraColors.accent,
            secondary: AuroraColors.accent,
            surface: AuroraColors.surface,
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
        // SplashPage checks SharedPreferences and decides where to route
        home: const SplashPage(),
        routes: {
          '/register': (_) => const RegisterPage(),
          '/dashboard': (_) => const MainShell(),
          '/add-task': (_) => const AddTaskScreen(),
          '/calendar': (_) => const CalendarScreen(),
          '/analytics': (_) => const AnalyticsScreen(),
          '/settings': (_) => const SettingsScreen(),
        },
      ),
    );
  }
}
