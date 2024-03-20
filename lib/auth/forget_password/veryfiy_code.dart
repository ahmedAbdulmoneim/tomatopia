import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:tomatopia/auth/forget_password/reset_password.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verification Code',
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Check Code',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Please Enter The Code Sent To :  Ahmed@gmail.com ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,

            ),
          ),
          const SizedBox(
            height: 30,
          ),
          OtpTextField(
              numberOfFields: 6,
              fieldWidth: 50,
              borderRadius: BorderRadius.circular(10),
              borderColor: Colors.greenAccent,
              showFieldAsBox: true,
              cursorColor: Colors.black,
              focusedBorderColor: Colors.greenAccent,
             fillColor: Colors.greenAccent,
              onCodeChanged: (String code) {

              },

              onSubmit: (String verificationCode){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(),));
              }, // end onSubmit
            ),
        ],
      ),
    );
  }
}
