import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/shared_widgets.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String _selectedPriority = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuroraColors.background,
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -100,
            left: -100,
            child: GlowDot(size: 300, color: AuroraColors.accent),
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
                        const Text(
                          'Add New Task',
                          style: AuroraTextStyles.heading1,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Create a new workflow node in the grid.',
                          style: AuroraTextStyles.body,
                        ),
                        const SizedBox(height: 40),
                        AuroraTextField(
                          label: 'TASK TITLE',
                          hint: 'e.g. Design System Review',
                          controller: _titleController,
                        ),
                        const SizedBox(height: 24),
                        AuroraTextField(
                          label: 'DESCRIPTION',
                          hint: 'Details about this task...',
                          controller: _descController,
                        ),
                        const SizedBox(height: 32),
                        Text('PRIORITY LEVEL', style: AuroraTextStyles.label),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildPriorityOption('Low', AuroraColors.green),
                            const SizedBox(width: 12),
                            _buildPriorityOption('Medium', AuroraColors.orange),
                            const SizedBox(width: 12),
                            _buildPriorityOption('High', AuroraColors.pink),
                          ],
                        ),
                        const SizedBox(height: 48),
                        AuroraButton(
                          text: 'Initialize Task',
                          onPressed: () => Navigator.pop(context),
                          icon: Icons.auto_mode_rounded,
                        ),
                        const SizedBox(height: 16),
                        AuroraButton(
                          text: 'Discard',
                          onPressed: () => Navigator.pop(context),
                          isPrimary: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
            Icons.close_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityOption(String label, Color color) {
    bool isSelected = _selectedPriority == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.15) : AuroraColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color.withValues(alpha: 0.5) : AuroraColors.divider,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? color : AuroraColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
