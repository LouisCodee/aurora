import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme.dart';
import 'shared_widgets.dart';
import '../features/tasks/presentation/bloc/tasks_bloc.dart';
import '../features/tasks/domain/entities/task_entity.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String _selectedPriority = 'Medium';
  TimeOfDay? _notificationTime;
  String _selectedDuration = '30 Min';
  final List<String> _durations = ['15 Min', '30 Min', '1 Hour', '2 Hours', 'Custom'];

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
                  const SizedBox(height: 24),

                  Text('TIME & DURATION', style: AuroraTextStyles.label),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTimePickerField(),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDurationDropdown(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  AuroraButton(
                    text: 'Create Task',
                    onPressed: () {
                      final title = _titleController.text.trim();
                      if (title.isEmpty) return; // Optionally show a toast

                      final desc = _descController.text.trim();
                      
                      final task = TaskEntity(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: title,
                        description: desc.isEmpty ? 'No description' : desc,
                        priority: _selectedPriority,
                        notificationTime: _notificationTime != null 
                            ? _notificationTime!.format(context) 
                            : 'No Time',
                        duration: _selectedDuration,
                      );

                      context.read<TasksBloc>().add(AddTask(task));
                      Navigator.pop(context);
                    },
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

  Widget _buildTimePickerField() {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: _notificationTime ?? TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AuroraColors.accent,
                  onPrimary: Colors.white,
                  surface: AuroraColors.surfaceLight,
                  onSurface: Colors.white,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AuroraColors.accent,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() {
            _notificationTime = picked;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AuroraColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AuroraColors.divider),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time_filled_rounded, color: AuroraColors.accent, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _notificationTime != null
                    ? _notificationTime!.format(context)
                    : 'Set Time',
                style: TextStyle(
                  color: _notificationTime != null ? Colors.white : AuroraColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AuroraColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AuroraColors.divider),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDuration,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AuroraColors.textSecondary),
          isDense: false,
          dropdownColor: AuroraColors.surfaceLight,
          isExpanded: true,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedDuration = newValue;
              });
            }
          },
          items: _durations.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  const Icon(Icons.timer_outlined, color: AuroraColors.purple, size: 18),
                  const SizedBox(width: 8),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
