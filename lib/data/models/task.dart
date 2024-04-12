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

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? 1,
      todo: json['todo'] ?? "",
      completed: json['completed'] ?? false,
      userId: json['userId'] ?? 5,
      isDeleted: json['isDeleted'] ?? false,
    );
  }
}
