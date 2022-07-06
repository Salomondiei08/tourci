class Comment {
  final String id;
  final String? title;
  final String message;
  final String userId;
  
  Comment({
    required this.id,
    this.title,
    required this.message,
    required this.userId,
  });
}
