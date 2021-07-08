import 'package:hive/hive.dart';
import 'package:basic_notes/models/note_model.dart';

class Boxes {
  static Box<NoteModel> getNotes() => Hive.box<NoteModel>('notes');
}
