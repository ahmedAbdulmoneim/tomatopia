import 'package:flutter/material.dart';
import 'package:tomatopia/auth/sign_up.dart';

import '../custom_widget/custom_button.dart';
import '../custom_widget/text_form_filed.dart';
import '../screens/home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image.asset(
                          'assets/tomato1.png',
                        ),
                        const Text(
                          'Login',
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
                        onSaved: (value) {},
                        label: 'Email address',
                        keyboardType: TextInputType.emailAddress,
                        prefix: Icons.alternate_email,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "email can't be empty";
                          }
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    textFormField(
                        onSaved: (value) {},
                        label: 'Password',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        prefix: Icons.password,
                        suffix: Icons.visibility_off_outlined,
                        validate: (password) {
                          if (password.toString().isEmpty) {
                            return "password can't be empty";
                          }
                        }),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forget Password',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                          }
                        },
                        text: 'LOGIN'),
                    Row(
                      children: [
                        const Text("Don't have an account "),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ));
                            },
                            child: const Text(
                              'SIGN UP',
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
