import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/shared_widgets.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuroraColors.background,
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -150,
            right: -100,
            child: GlowDot(size: 350, color: AuroraColors.accent),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        const Text('Calendar View', style: AuroraTextStyles.heading1),
                        const SizedBox(height: 24),
                        _buildCalendarWidget(),
                        const SizedBox(height: 32),
                        _buildSectionHeader('Schedule for Today'),
                        const SizedBox(height: 16),
                        _buildScheduleItem('09:00 AM', 'Daily Standup', 'High', AuroraColors.pink),
                        const SizedBox(height: 12),
                        _buildScheduleItem('11:30 AM', 'UI Design Review', 'Medium', AuroraColors.orange),
                        const SizedBox(height: 12),
                        _buildScheduleItem('02:00 PM', 'Client Meeting', 'High', AuroraColors.pink),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: AuroraNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
                if (index == 3) Navigator.pushReplacementNamed(context, '/analytics');
                if (index == 4) Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AuroraColors.surfaceLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AuroraColors.divider),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AuroraDecorations.glowCard(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'October 2024',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.chevron_left_rounded, color: AuroraColors.textDim),
                  const SizedBox(width: 16),
                  Icon(Icons.chevron_right_rounded, color: AuroraColors.textDim),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildWeekDays(),
          const SizedBox(height: 16),
          _buildDaysGrid(),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((day) => Expanded(
        child: Center(
          child: Text(
            day,
            style: const TextStyle(
              color: AuroraColors.textDim,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildDaysGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 31,
      itemBuilder: (context, index) {
        int day = index + 1;
        bool isSelected = day == 24;
        bool hasDot = day == 15 || day == 28;

        return Container(
          decoration: BoxDecoration(
            color: isSelected ? AuroraColors.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSelected ? null : Border.all(color: AuroraColors.divider.withOpacity(0.5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$day',
                style: TextStyle(
                  color: isSelected ? AuroraColors.background : Colors.white,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
              if (hasDot && !isSelected) ...[
                const SizedBox(height: 4),
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AuroraColors.accent,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: AuroraTextStyles.heading3);
  }

  Widget _buildScheduleItem(String time, String title, String priority, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AuroraDecorations.glowCard(radius: 16),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              time,
              style: const TextStyle(
                color: AuroraColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: 2,
            height: 30,
            color: color.withOpacity(0.3),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                PriorityBadge(label: priority, color: color),
              ],
            ),
          ),
          const Icon(Icons.more_vert_rounded, color: AuroraColors.textDim, size: 20),
        ],
      ),
    );
  }
}
