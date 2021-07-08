import 'package:basic_notes/models/note_model.dart';

class AllNotes {
  final List<NoteModel> _allNotes = [
    NoteModel(
      title: 'First note',
      body:
          'Est et earum nihil. Velit qui necessitatibus ad et. Esse libero voluptatem voluptatum eaque culpa enim et earum. Aut qui earum ut incidunt enim accusantium. Quo ut sequi praesentium ullam in eius.',
    ),
    NoteModel(
      title: 'Second note',
      body:
          'Aut quis rerum et dolorem ut excepturi quod. Molestias nisi omnis tempore doloremque dolores dicta. Enim dolorem impedit saepe eum.',
    ),
    NoteModel(
      title: 'Third note',
      body:
          'Deleniti aut iure soluta inventore neque tempora unde. Est labore facilis dolor quos quo. Qui voluptatem eum consectetur et.',
    ),
    NoteModel(
      title: 'First note',
      body:
          'Est et earum nihil. Velit qui necessitatibus ad et. Esse libero voluptatem voluptatum eaque culpa enim et earum. Aut qui earum ut incidunt enim accusantium. Quo ut sequi praesentium ullam in eius.',
    ),
    NoteModel(
      title: 'Second note',
      body:
          'Aut quis rerum et dolorem ut excepturi quod. Molestias nisi omnis tempore doloremque dolores dicta. Enim dolorem impedit saepe eum.',
    ),
    NoteModel(
      title: 'Third note',
      body:
          'Deleniti aut iure soluta inventore neque tempora unde. Est labore facilis dolor quos quo. Qui voluptatem eum consectetur et.',
    ),
    NoteModel(
      title: 'First note',
      body:
          'Est et earum nihil. Velit qui necessitatibus ad et. Esse libero voluptatem voluptatum eaque culpa enim et earum. Aut qui earum ut incidunt enim accusantium. Quo ut sequi praesentium ullam in eius.',
    ),
    NoteModel(
      title: 'Second note',
      body:
          'Aut quis rerum et dolorem ut excepturi quod. Molestias nisi omnis tempore doloremque dolores dicta. Enim dolorem impedit saepe eum.',
    ),
    NoteModel(
      title: 'Third note',
      body:
          'Deleniti aut iure soluta inventore neque tempora unde. Est labore facilis dolor quos quo. Qui voluptatem eum consectetur et.',
    ),
  ];

  List<NoteModel> get allNotes {
    return [..._allNotes];
  }

  void addNewNote(NoteModel note) {
    final newNote = NoteModel(
      title: note.title,
      body: note.body,
      isPinned: note.isPinned,
    );
    _allNotes.add(newNote);
  }
}
