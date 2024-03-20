import 'package:flutter/material.dart';

import '../../constant/validate_password.dart';
import '../../custom_widget/custom_button.dart';
import '../../custom_widget/text_form_filed.dart';

class ResetPassword extends StatelessWidget {
   ResetPassword({Key? key}) : super(key: key);
  final GlobalKey<FormState>formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Reset Password',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'NEW PASSWORD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Please Enter Your New Password ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,

                ),
              ),
              const SizedBox(
                height: 30,
              ),
              textFormField(
                validate: (value) {
                  if (value.isEmpty) {
                    return "password can't be empty";
                  }
                  return validatePassword(value);
                },
                onSaved: (value) {},
                prefix: Icons.password,
                label: 'Password ',
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 10,
              ),
              textFormField(
                validate: (value) {
                  if (value.isEmpty) {
                    return "password can't be empty";
                  }
                  return validatePassword(value);
                },
                onSaved: (value) {},
                prefix: Icons.password,
                label: 'Confirm password ',
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 20,
              ),
              customButton(
                  text: 'Save',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {

                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
