import 'dart:convert';
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String notificationTime;
  final String duration;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.notificationTime,
    required this.duration,
  });

  @override
  List<Object?> get props => [id, title, description, priority, notificationTime, duration];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'notificationTime': notificationTime,
      'duration': duration,
    };
  }

  factory TaskEntity.fromMap(Map<String, dynamic> map) {
    return TaskEntity(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      notificationTime: map['notificationTime'],
      duration: map['duration'],
    );
  }

  String toJson() => json.encode(toMap());
  factory TaskEntity.fromJson(String source) => TaskEntity.fromMap(json.decode(source));
}
