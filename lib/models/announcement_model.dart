class Announcement {
  final String id;
  final String title;
  final String content;
  final DateTime datePosted;
  final String author;
  final bool isImportant;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.datePosted,
    required this.author,
    this.isImportant = false,
  });
}
