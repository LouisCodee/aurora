import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/shared_widgets.dart';
import '../core/di/injection_container.dart';
import '../features/register/domain/repositories/register_repository.dart';
import '../features/register/domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/tasks/presentation/bloc/tasks_bloc.dart';
import '../features/tasks/domain/entities/task_entity.dart';

class DashboardScreen extends StatefulWidget {
  final bool isInternal;
  const DashboardScreen({super.key, this.isInternal = false});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserEntity? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await sl<RegisterRepository>().getSavedUser();
    if (mounted) {
      setState(() {
        currentUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: GlowDot(size: 300, color: AuroraColors.accent),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: GlowDot(size: 200, color: AuroraColors.purple),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Expanded(
                  child: BlocBuilder<TasksBloc, TasksState>(
                    builder: (context, state) {
                      List<TaskEntity> tasks = [];
                      if (state is TasksLoaded) {
                        tasks = state.tasks;
                      }
                      final upNext = tasks.isNotEmpty ? tasks.first : null;
                      final otherTasks = tasks.length > 1 ? tasks.skip(1).take(3).toList() : <TaskEntity>[];

                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32),
                            _buildGreeting(),
                            const SizedBox(height: 32),
                            _buildProjectDeadlineCard(upNext),
                            const SizedBox(height: 40),
                            _buildSectionHeader('Upcoming Tasks', 'See all'),
                            const SizedBox(height: 16),
                            if (otherTasks.isEmpty && upNext == null) ...[
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: Text(
                                    'Looks like your schedule is completely clear.',
                                    style: TextStyle(color: AuroraColors.textSecondary),
                                  ),
                                ),
                              ),
                            ] else ...[
                              ...otherTasks.map((t) {
                                Color color;
                                IconData icon;
                                switch(t.priority) {
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
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _buildTaskItem(t.title, '${t.notificationTime} • ${t.duration}', t.priority, color, icon),
                                );
                              }),
                            ],
                            const SizedBox(height: 100),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      );

    if (widget.isInternal) return body;
    return Scaffold(
      backgroundColor: AuroraColors.background,
      body: body,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AuroraColors.surfaceLight,
              shape: BoxShape.circle,
              border: Border.all(color: AuroraColors.divider),
            ),
            child: const Icon(Icons.grid_view_rounded, size: 20, color: Colors.white),
          ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AuroraColors.accent, width: 2),
            ),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AuroraColors.accent.withValues(alpha: 0.2),
              child: Text(
                currentUser?.name.isNotEmpty == true 
                    ? currentUser!.name[0].toUpperCase() 
                    : 'A',
                style: const TextStyle(
                  color: AuroraColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    String greeting = 'Hello';
    final hour = DateTime.now().hour;
    if (hour < 12) greeting = 'Good Morning';
    else if (hour < 17) greeting = 'Good Afternoon';
    else greeting = 'Good Evening';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting, ${currentUser?.name ?? 'Guest'}',
          style: AuroraTextStyles.heading1,
        ),
        const SizedBox(height: 4),
        Text(
          '${_getFormattedDate()}',
          style: AuroraTextStyles.body,
        ),
      ],
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  Widget _buildProjectDeadlineCard(TaskEntity? task) {
    if (task == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: AuroraDecorations.accentCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const PriorityBadge(label: 'ALL CLEAR', color: Colors.white),
                const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'No upcoming tasks!',
              style: AuroraTextStyles.heading2,
            ),
            const SizedBox(height: 8),
            const Text(
              'Take a moment to relax or tap the + button to add a new objective.',
              style: AuroraTextStyles.bodySmall,
            ),
          ],
        ),
      );
    }

    Color color;
    switch(task.priority) {
      case 'High':
        color = AuroraColors.pink;
        break;
      case 'Medium':
        color = AuroraColors.orange;
        break;
      default:
        color = AuroraColors.green;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: AuroraDecorations.accentCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PriorityBadge(label: task.priority.toUpperCase(), color: color),
              const Icon(Icons.more_horiz_rounded, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            task.title,
            style: AuroraTextStyles.heading2,
          ),
          if (task.description.isNotEmpty && task.description != 'No description') ...[
            const SizedBox(height: 8),
            Text(
              task.description,
              style: AuroraTextStyles.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.timer_outlined, color: AuroraColors.accent, size: 16),
              const SizedBox(width: 8),
              Text(
                '${task.notificationTime} • ${task.duration}',
                style: const TextStyle(
                  color: AuroraColors.accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              _buildAvatarStack(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarStack() {
    return SizedBox(
      width: 70,
      height: 30,
      child: Stack(
        children: [
          _buildAvatar(0, 'https://i.pravatar.cc/150?u=1'),
          _buildAvatar(15, 'https://i.pravatar.cc/150?u=2'),
          _buildAvatar(30, 'https://i.pravatar.cc/150?u=3'),
        ],
      ),
    );
  }

  Widget _buildAvatar(double left, String url) {
    return Positioned(
      left: left,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AuroraColors.background, width: 2),
        ),
        child: CircleAvatar(
          radius: 13,
          backgroundImage: NetworkImage(url),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AuroraTextStyles.heading3),
        Text(
          action,
          style: const TextStyle(
            color: AuroraColors.accent,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(
    String title,
    String due,
    String priority,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AuroraDecorations.glowCard(radius: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(due, style: AuroraTextStyles.bodySmall),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AuroraColors.textDim),
        ],
      ),
    );
  }
}
