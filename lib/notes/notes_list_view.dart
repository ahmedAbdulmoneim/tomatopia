import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/notes/edit_note_bottom_sheet.dart';
import 'package:tomatopia/shared_preferences/shared_preferences.dart';
import 'add_note_bottom_sheet.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await SharedPreference.getData(key: 'userId');
    setState(() {});
  }

  Stream<QuerySnapshot> fetchNotesForUser(String userId) {
    return FirebaseFirestore.instance
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Center(child: CircularProgressIndicator(color: Colors.green));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: fetchNotesForUser(userId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.green));
        }

        if (snapshot.hasError) {
          return Center(child: Text('${context.error}: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text(context.noNotes));
        }

        final notes = snapshot.data!.docs;

        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index].data() as Map<String, dynamic>;
            final noteContent = note['note'];
            final noteId = notes[index].id;
            final notificationTime = note['notificationTime'] != null
                ? (note['notificationTime'] as Timestamp).toDate()
                : null;

            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => EditNoteBottomSheet(
                    notification: notificationTime,
                    subtitle: noteContent,
                    notId: noteId,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 10),
                      child: InkWell(
                        onTap: () {
                          // Delete functionality here
                          FirebaseFirestore.instance.collection('notes').doc(noteId).delete();
                        },
                        child: Icon(Icons.delete_forever),
                      ),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          noteContent,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10), // Add spacing between text and date
                        Text(
                          '${DateFormat('yyyy-MM-dd, hh:mm a').format(notificationTime!)}',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
