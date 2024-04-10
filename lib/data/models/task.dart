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
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
      limit: json['limit'],
      skip: json['skip'],
    );
  }
}
