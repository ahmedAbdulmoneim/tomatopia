// AddNoteForm.dart

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/custom_widget/toasts.dart';
import '../shared_preferences/shared_preferences.dart';

DateTime scheduleDateTime = DateTime.now();

class AddNoteForm extends StatefulWidget {
  AddNoteForm({Key? key}) : super(key: key);

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  TextEditingController noteContent = TextEditingController();

  String? subtitle;
  bool isLoading = false;
  DateTime? _selectedDateTime;

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
                Center(child: Text(context.addNewNote,)),
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
                subtitle = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return context.thisFieldCannotBeNull;
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: context.writeTaskToDo,
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
      if (scheduleDateTime.isAfter(DateTime.now()) || scheduleDateTime.isAtSameMomentAs(DateTime.now())) {
        await FirebaseFirestore.instance.collection('notes').doc().set({
          "createdAt": DateTime.now(),
          "note": subtitle,
          "notificationTime": scheduleDateTime,
          "userId": userId,
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
