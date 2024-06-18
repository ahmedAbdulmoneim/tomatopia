// EditNoteForm.dart

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/custom_widget/toasts.dart';
import '../shared_preferences/shared_preferences.dart';

DateTime scheduleDateTime = DateTime.now();

class EditNoteForm extends StatefulWidget {
  final DateTime notification;
  final String subtitle;
  final String noteId;

  EditNoteForm({
    Key? key,
    required this.notification,
    required this.subtitle,
    required this.noteId,
  }) : super(key: key);

  @override
  State<EditNoteForm> createState() => _EditNoteFormState();
}

class _EditNoteFormState extends State<EditNoteForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  TextEditingController noteContent = TextEditingController();
  String? content;
  bool isLoading = false;
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    // Initialize the text controller with the current note content
    noteContent.text = widget.subtitle;
    // Set the initial scheduleDateTime to the current notification time
    scheduleDateTime = widget.notification;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidateMode,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 10,
          right: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      await _saveNote();
                    } else {
                      autoValidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.done),
                ),
                const Spacer(),
                Center(child: Text(context.editNote)),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
            TextFormField(
              controller: noteContent,
              maxLines: null,
              enabled: true,
              onSaved: (value) {
                content = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return context.thisFieldCannotBeNull;
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: context.editYourNote,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.greenAccent),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: () {
                _showDateTimePicker(context);
              },
              icon: const Icon(Icons.add_alert_rounded),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDateTimePicker(BuildContext context) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onChanged: (date) => scheduleDateTime = date,
      onConfirm: (date) {
        setState(() {
          _selectedDateTime = date;
        });
      },
    );
  }

  Future<void> _saveNote() async {
    try {
      final userId = await SharedPreference.getData(key: "userId");
      if (userId == '') {
        // Handle the case where userId is not available
        print("User ID not found in SharedPreferences");
        return;
      }
      // Use the selected date time if available, otherwise keep the old one
      final DateTime finalDateTime = _selectedDateTime ?? widget.notification;
      if (finalDateTime.isAfter(DateTime.now()) || finalDateTime.isAtSameMomentAs(DateTime.now())) {
        await FirebaseFirestore.instance.collection('notes').doc(widget.noteId).update({
          "note": noteContent.text,
          "notificationTime": finalDateTime,
        });
        Navigator.pop(context);
      } else {
        show(context, context.error, context.chooseValidDate, Colors.red);
      }
    } catch (e) {
      print(e);
    }
  }
}
