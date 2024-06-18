import 'package:flutter/material.dart';
import 'package:tomatopia/notes/add_note_form.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddNoteForm();
  }
}
