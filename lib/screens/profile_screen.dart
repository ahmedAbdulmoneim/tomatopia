import 'package:flutter/material.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                          radius: 90,
                          backgroundImage:
                              AssetImage('assets/no_profile_image.png')),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_a_photo_sharp),
                        color: Colors.black,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textFormField(
                    prefix: Icons.person,
                    label: 'change name',
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return 'please enter valid name ';
                      }
                    },
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customButton(
                      text: 'Save changes',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {});
                        }
                      },
                      width: double.infinity),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
