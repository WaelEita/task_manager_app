class Task {
  final int id;
  final String todo;
  final bool completed;
  final int userId;
  final int limit;
  final int skip;

  Task({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
    required this.limit,
    required this.skip,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? 1,
      todo: json['todo'] ?? "",
      completed: json['completed'] ?? false,
      userId: json['userId'] ?? 5,
      limit: json['limit'] ?? 3,
      skip: json['skip'] ?? 0,
    );
  }
}
