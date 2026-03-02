import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'shared_widgets.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String _selectedPriority = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: AuroraColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AuroraColors.divider,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Add New Task', style: AuroraTextStyles.heading2),
                  const SizedBox(height: 4),
                  Text(
                    'Define your next objective',
                    style: AuroraTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 32),

                  AuroraTextField(
                    label: 'TASK TITLE',
                    hint: 'e.g. Design Research',
                    controller: _titleController,
                  ),
                  const SizedBox(height: 20),

                  AuroraTextField(
                    label: 'DESCRIPTION',
                    hint: 'What needs to be done?',
                    controller: _descController,
                  ),
                  const SizedBox(height: 24),

                  Text('PRIORITY', style: AuroraTextStyles.label),
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
                  const SizedBox(height: 32),

                  AuroraButton(
                    text: 'Create Task',
                    onPressed: () => Navigator.pop(context),
                    icon: Icons.add_rounded,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
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
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: 0.15)
                : AuroraColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color.withValues(alpha: 0.5) : AuroraColors.divider,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? color : AuroraColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
