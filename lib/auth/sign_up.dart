import 'package:flutter/material.dart';

import '../custom_widget/custom_button.dart';
import '../custom_widget/text_form_filed.dart';
import '../screens/home.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image.asset(
                          'assets/tomato4.png',
                        ),
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 25),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textFormField(
                        validate: (value) {
                          if (value.isEmpty) {
                            return "Name is required";
                          }
                        },
                        prefix: Icons.person,
                        label: 'Full Name ',
                        keyboardType: TextInputType.name,
                        onSaved: (value) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Email is required";
                        }
                      },
                      onSaved: (value) {},
                      prefix: Icons.alternate_email_rounded,
                      label: 'Email address',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Password is required";
                        }
                      },
                      onSaved: (value) {},
                      prefix: Icons.password,
                      suffix: Icons.remove_red_eye,
                      label: 'Password ',
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Password is required";
                        }
                      },
                      onSaved: (value) {},
                      prefix: Icons.password,
                      suffix: Icons.remove_red_eye,
                      label: 'Confirm Password',
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customButton(
                        text: 'SIGN UP',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                          }
                        }),
                    Row(
                      children: [
                        const Text("Already  have an account "),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
