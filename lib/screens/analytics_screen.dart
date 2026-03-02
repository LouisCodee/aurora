import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/shared_widgets.dart';

class AnalyticsScreen extends StatefulWidget {
  final bool isInternal;
  const AnalyticsScreen({super.key, this.isInternal = false});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {

  @override
  Widget build(BuildContext context) {
    Widget body = Stack(
        children: [
          // Background Glow
          Positioned(
            top: -100,
            left: -100,
            child: GlowDot(size: 300, color: AuroraColors.purple),
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
                        const Text('Productivity Analytics', style: AuroraTextStyles.heading1),
                        const SizedBox(height: 8),
                        const Text('Analyze your performance metrics.', style: AuroraTextStyles.body),
                        const SizedBox(height: 32),
                        _buildMainStats(),
                        const SizedBox(height: 32),
                        _buildSectionHeader('Weekly Activity'),
                        const SizedBox(height: 20),
                        _buildBarChart(),
                        const SizedBox(height: 40),
                        _buildSectionHeader('Task Categories'),
                        const SizedBox(height: 20),
                        _buildCategoryStats(),
                        const SizedBox(height: 100),
                      ],
                    ),
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

  Widget _buildMainStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('Tasks Done', '42', Icons.check_circle_rounded, AuroraColors.accent),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard('Total Hours', '128', Icons.timer_rounded, AuroraColors.purple),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AuroraDecorations.glowCard(radius: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: AuroraTextStyles.bodySmall),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: AuroraTextStyles.heading3);
  }

  Widget _buildBarChart() {
    final values = [0.4, 0.7, 0.5, 0.9, 0.6, 0.8, 0.4];
    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: AuroraDecorations.glowCard(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: 24,
                height: 120 * values[index],
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AuroraColors.accent,
                      AuroraColors.accent.withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                      color: AuroraColors.accent.withValues(alpha: 0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                labels[index],
                style: const TextStyle(color: AuroraColors.textDim, fontSize: 10),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCategoryStats() {
    return Column(
      children: [
        _buildCategoryItem('UI/UX Design', 85, AuroraColors.accent),
        const SizedBox(height: 16),
        _buildCategoryItem('Development', 65, AuroraColors.purple),
        const SizedBox(height: 16),
        _buildCategoryItem('Marketing', 40, AuroraColors.orange),
      ],
    );
  }

  Widget _buildCategoryItem(String name, int percentage, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AuroraDecorations.glowCard(radius: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                '$percentage%',
                style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 6,
                decoration: BoxDecoration(
                  color: AuroraColors.divider,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
