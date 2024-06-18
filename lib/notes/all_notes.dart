import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'add_note_bottom_sheet.dart';
import 'notes_list_view.dart';
import 'package:tomatopia/cubit/home_cubit/home_cubit.dart';

class NotesView extends StatelessWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.notes),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const AddNoteBottomSheet(


            ),
          );
        },
        backgroundColor: Colors.greenAccent[200],
        child: const Icon(Icons.add),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: NoteList(),
      ),
    );
  }
}
