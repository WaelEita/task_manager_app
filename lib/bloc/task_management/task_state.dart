import '../../data/models/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

class TaskAdded extends TaskState {
  final Task task;

  TaskAdded(this.task);
}

class TaskUpdated extends TaskState {
  final Task task;

  TaskUpdated(this.task);
}

class TaskDeleted extends TaskState {
  final Task task;

  TaskDeleted(this.task);
}