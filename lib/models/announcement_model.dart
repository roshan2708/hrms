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

  static List<Announcement> get dummyAnnouncements => [
        Announcement(
          id: 'A01',
          title: 'Q4 Townhall Meeting',
          content: 'Join us for the Q4 Townhall tomorrow at 10 AM. We will discuss the new roadmap and upcoming product releases.',
          datePosted: DateTime.now().subtract(const Duration(hours: 4)),
          author: 'HR Department',
          isImportant: true,
        ),
        Announcement(
          id: 'A02',
          title: 'New Health Insurance Policy',
          content: 'We have upgraded our corporate health insurance. Check your email for details regarding dependents and coverage limits.',
          datePosted: DateTime.now().subtract(const Duration(days: 2)),
          author: 'HR Department',
        ),
        Announcement(
          id: 'A03',
          title: 'Welcome New Hires!',
          content: 'Please welcome Sarah and John to the Engineering team. They will be joining the frontend squad starting Monday.',
          datePosted: DateTime.now().subtract(const Duration(days: 5)),
          author: 'Engineering VP',
        ),
        Announcement(
          id: 'A04',
          title: 'Office Relocation Update',
          content: 'The 3rd-floor renovations are complete. Affected staff can begin moving back to their original desks on Friday.',
          datePosted: DateTime.now().subtract(const Duration(days: 8)),
          author: 'Facilities',
        ),
      ];
}
