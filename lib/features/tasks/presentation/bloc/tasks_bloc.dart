import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/task_entity.dart';

abstract class TasksEvent {}
class LoadTasks extends TasksEvent {}
class AddTask extends TasksEvent {
  final TaskEntity task;
  AddTask(this.task);
}

abstract class TasksState {}
class TasksLoading extends TasksState {}
class TasksLoaded extends TasksState {
  final List<TaskEntity> tasks;
  TasksLoaded(this.tasks);
}
class TasksError extends TasksState {
  final String message;
  TasksError(this.message);
}

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final SharedPreferences prefs;
  static const _kTasksKey = 'aurora_tasks';

  TasksBloc(this.prefs) : super(TasksLoading()) {
    on<LoadTasks>((event, emit) {
      try {
        final List<String> tasksJson = prefs.getStringList(_kTasksKey) ?? [];
        final tasks = tasksJson.map((t) => TaskEntity.fromJson(t)).toList();
        emit(TasksLoaded(tasks.reversed.toList())); // Most recent first
      } catch (e) {
        emit(TasksError("Failed to load tasks"));
      }
    });

    on<AddTask>((event, emit) async {
      try {
        final currentTasks = prefs.getStringList(_kTasksKey) ?? [];
        currentTasks.add(event.task.toJson());
        await prefs.setStringList(_kTasksKey, currentTasks);
        add(LoadTasks());
      } catch (e) {
        emit(TasksError("Failed to save task"));
      }
    });
  }
}
