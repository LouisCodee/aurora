import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/shared_widgets.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Design Workspace Module',
      'deadline': 'Due today, 6:00 PM',
      'priority': 'High',
      'color': AuroraColors.pink,
      'icon': Icons.design_services_rounded,
    },
    {
      'title': 'Review API Integration',
      'deadline': 'Due tomorrow, 10:00 AM',
      'priority': 'Medium',
      'color': AuroraColors.accent,
      'icon': Icons.api_rounded,
    },
    {
      'title': 'Weekly Sync Meeting',
      'deadline': 'Oct 28, 02:00 PM',
      'priority': 'Low',
      'color': AuroraColors.green,
      'icon': Icons.groups_rounded,
    },
    {
      'title': 'Update Documentation',
      'deadline': 'Oct 30, 11:59 PM',
      'priority': 'Low',
      'color': AuroraColors.purple,
      'icon': Icons.description_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Active Tasks', style: AuroraTextStyles.heading1),
              const SizedBox(height: 8),
              Text(
                'Managing ${_tasks.length} objectives',
                style: AuroraTextStyles.body,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
            itemCount: _tasks.length,
            separatorBuilder: (ctx, i) => const SizedBox(height: 16),
            itemBuilder: (ctx, i) {
              final task = _tasks[i];
              return _buildTaskCard(task);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AuroraDecorations.glowCard(radius: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: task['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(task['icon'], color: task['color'], size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        task['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    PriorityBadge(label: task['priority'], color: task['color']),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, color: AuroraColors.textDim, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      task['deadline'],
                      style: AuroraTextStyles.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
