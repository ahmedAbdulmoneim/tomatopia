import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tomatopia/auth/forget_password/reset_password.dart';
import 'package:tomatopia/cubit/auth_cubit/forget_password/forget_password_cubit.dart';
import 'package:tomatopia/cubit/auth_cubit/forget_password/forget_password_states.dart';
import 'package:tomatopia/custom_widget/extensions.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.verificationCode),
        centerTitle: true,
      ),
      body: BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
        builder: (context, state) {
          var cubit = BlocProvider.of<ForgetPasswordCubit>(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.checkCode,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '${context.pleaseEnterVerificationCode} ${cubit.forgetPasswordModel!.email}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              OtpTextField(
                numberOfFields: 6,
                fieldWidth: 50,
                clearText: true,
                borderRadius: BorderRadius.circular(10),
                borderColor: Colors.greenAccent,
                showFieldAsBox: true,
                cursorColor: Colors.black,
                focusedBorderColor: Colors.greenAccent,
                fillColor: Colors.greenAccent,
                onCodeChanged: (String code) {},

                onSubmit: (String verificationCode) {
                  if (cubit.forgetPasswordModel!.confirmCode == verificationCode) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPassword(),
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: context.codeNotTrue,
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: Colors.red,
                      timeInSecForIosWeb: 5,
                      textColor: Colors.white,
                      fontSize: 16.5,
                      gravity: ToastGravity.CENTER,
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
