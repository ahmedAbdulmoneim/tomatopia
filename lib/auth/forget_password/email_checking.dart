import 'package:flutter/material.dart';
import 'package:tomatopia/auth/forget_password/veryfiy_code.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

class EmailChecking extends StatelessWidget {
   EmailChecking({Key? key}) : super(key: key);
  GlobalKey<FormState>formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Forget Password',
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'CHECK EMAIL',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Please Enter Your Email Address To Receive Verification Code ',
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
                onSaved: (value) {},
                label: 'enter your email',
                prefix: Icons.email_outlined,
                validate: (value) {
                  if(value.toString().isEmpty){
                    return 'enter an email to get code';
                  }
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              customButton(text: 'CHECK', onPressed: (){
                if(formKey.currentState!.validate()){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCode(),));

                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
