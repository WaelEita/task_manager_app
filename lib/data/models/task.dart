class Task {
  final int id;
  final String todo;
  final bool completed;
  final int userId;
  final bool isDeleted;

  Task({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
    required this.isDeleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      todo: json['todo'] ?? '',
      completed: json['completed'] ?? false,
      userId: json['userId'] ?? 0,
      isDeleted: json['isDeleted'] ?? false,
    );
  }

}
