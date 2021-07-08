class NoteModel {
  final String title;
  final String body;
  final DateTime saveDate;
  final bool isPinned;

  NoteModel(
      {required this.title,
      required this.body,
      required this.saveDate,
      this.isPinned = false});
}
