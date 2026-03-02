import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/shared_widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuroraColors.background,
      body: Stack(
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        _buildGreeting(),
                        const SizedBox(height: 32),
                        _buildProjectDeadlineCard(),
                        const SizedBox(height: 40),
                        _buildSectionHeader('Upcoming Tasks', 'See all'),
                        const SizedBox(height: 16),
                        _buildTaskItem(
                          'Review Marketing Assets',
                          'Due in 2 hours',
                          'High',
                          AuroraColors.pink,
                          Icons.campaign_rounded,
                        ),
                        const SizedBox(height: 16),
                        _buildTaskItem(
                          'Grocery Shopping',
                          'Due tomorrow',
                          'Medium',
                          AuroraColors.orange,
                          Icons.shopping_cart_rounded,
                        ),
                        const SizedBox(height: 16),
                        _buildTaskItem(
                          'Yoga Session',
                          'Oct 26, 08:00 AM',
                          'Low',
                          AuroraColors.green,
                          Icons.self_improvement_rounded,
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Navigation
          Align(
            alignment: Alignment.bottomCenter,
            child: AuroraNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
                if (index == 2) Navigator.pushNamed(context, '/calendar');
                if (index == 3) Navigator.pushNamed(context, '/analytics');
                if (index == 4) Navigator.pushNamed(context, '/settings');
              },
            ),
          ),

          // FAB
          Positioned(
            bottom: 95,
            right: 24,
            child: FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, '/add-task'),
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
            child: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=luis'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Good Evening, Luis',
          style: AuroraTextStyles.heading1,
        ),
        const SizedBox(height: 4),
        Text(
          'Monday, October 24',
          style: AuroraTextStyles.body,
        ),
      ],
    );
  }

  Widget _buildProjectDeadlineCard() {
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
              const PriorityBadge(label: 'URGENT', color: AuroraColors.accent),
              const Icon(Icons.more_horiz_rounded, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Project Alpha Deadline',
            style: AuroraTextStyles.heading2,
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete all design handovers for the mobile workspace module.',
            style: AuroraTextStyles.bodySmall,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.timer_outlined, color: AuroraColors.accent, size: 16),
              const SizedBox(width: 8),
              const Text(
                'Today, 11:59 PM',
                style: TextStyle(
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
              color: color.withOpacity(0.1),
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
