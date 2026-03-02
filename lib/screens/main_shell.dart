import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/add_task_modal.dart';
import 'dashboard_screen.dart';
import 'tasks_screen.dart';
import 'calendar_screen.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(isInternal: true),
    const TasksScreen(),
    const CalendarScreen(isInternal: true),
    const AnalyticsScreen(isInternal: true),
    const SettingsScreen(isInternal: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuroraColors.background,
      body: Stack(
        children: [
          // Preserve state using IndexedStack
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),

          // Global Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: AuroraNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
            ),
          ),

          // Global FAB (Only visible on Dashboard and Tasks)
          if (_currentIndex == 0 || _currentIndex == 1)
            Positioned(
              bottom: 95,
              right: 24,
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const AddTaskModal(),
                  );
                },
                backgroundColor: AuroraColors.accent,
                foregroundColor: AuroraColors.background,
                shape: const CircleBorder(),
                elevation: 4,
                child: const Icon(Icons.add, size: 28),
              ),
            ),
        ],
      ),
    );
  }
}
