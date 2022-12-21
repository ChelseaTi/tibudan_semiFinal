class POSTS {
  final int id;
  final int userId;
  final String completed;
  final String title;

  const POSTS({required this.userId, required this.completed, required this.id, required this.title});

  factory POSTS.fromJson(Map<String, dynamic> json) {
    return POSTS(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}