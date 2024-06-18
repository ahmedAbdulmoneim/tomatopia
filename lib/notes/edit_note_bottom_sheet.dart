import 'package:flutter/material.dart';
import 'package:tomatopia/notes/edit_note_form.dart';

class EditNoteBottomSheet extends StatelessWidget {
  const EditNoteBottomSheet(
      {Key? key,
      required this.notification,
      required this.subtitle,
      required this.notId})
      : super(key: key);

  final DateTime notification;
  final String subtitle;
  final String notId;

  @override
  Widget build(BuildContext context) {
    return EditNoteForm(
      notification: notification,
      subtitle: subtitle,
      noteId: notId,
    );
  }
}
