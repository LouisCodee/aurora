import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme.dart';
import '../widgets/shared_widgets.dart';
import '../features/tasks/presentation/bloc/tasks_bloc.dart';
import '../features/tasks/domain/entities/task_entity.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoaded) {
          final tasks = state.tasks;
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Active Tasks', style: AuroraTextStyles.heading1),
                      const SizedBox(height: 8),
                      Text(
                        'Managing ${tasks.length} objectives',
                        style: AuroraTextStyles.body,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: tasks.isEmpty
                      ? const Center(
                          child: Text(
                            'No active tasks. Create a new one!',
                            style: TextStyle(color: AuroraColors.textSecondary, fontSize: 16),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                          itemCount: tasks.length,
                          separatorBuilder: (ctx, i) => const SizedBox(height: 16),
                          itemBuilder: (ctx, i) {
                            final task = tasks[i];
                            return _buildTaskCard(task);
                          },
                        ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AuroraColors.accent),
          ),
        );
      },
    );
  }

  Widget _buildTaskCard(TaskEntity task) {
    Color color;
    IconData icon;
    
    switch(task.priority) {
      case 'High':
        color = AuroraColors.pink;
        icon = Icons.notifications_active_rounded;
        break;
      case 'Medium':
        color = AuroraColors.orange;
        icon = Icons.assignment_rounded;
        break;
      default:
        color = AuroraColors.green;
        icon = Icons.check_circle_outline_rounded;
        break;
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AuroraDecorations.glowCard(radius: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (task.description.isNotEmpty && task.description != 'No description')
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                task.description,
                                style: const TextStyle(
                                  color: AuroraColors.textSecondary,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    PriorityBadge(label: task.priority, color: color),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, color: AuroraColors.textDim, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      '${task.notificationTime} • ${task.duration}',
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
