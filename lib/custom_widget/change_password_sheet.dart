import 'package:flutter/material.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

import '../constant/validate_password.dart';

Widget changePasswordBottomSheetBuilder({
  required bottomSheetFormKey,
  required buildContext,
  required save,
  required cancel,
  required notNull,
  required enterOldPassword,
  required confirmNewPassword,
  required confirmPasswordController,
  required oldPasswordController,
  required newPasswordController,
  required profileCubit,
}) => Form(
  key: bottomSheetFormKey,
  child: Container(
    height: 350,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(buildContext).viewInsets.bottom,
        top: 20,
        left: 10,
        right: 10),
    child: Column(
      children: [
        textFormField(
          validate: (value) {
            if (value.toString().isEmpty) {
              return notNull;
            }
            return validatePassword(value);
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: profileCubit.isSecure,
          prefix: Icons.password,
          suffix: profileCubit.suffixIcon,
          suffixFunc: profileCubit.suffixFunction,
          label: enterOldPassword,
          controller: oldPasswordController,
        ),
        const SizedBox(height: 15),
        textFormField(
          validate: (value) {
            if (value.toString().isEmpty) {
              return notNull;
            }
            return validatePassword(value);
          },
          keyboardType: TextInputType.visiblePassword,
          prefix: Icons.password,
          obscureText: profileCubit.isSecure,
          label: enterOldPassword,
          controller: newPasswordController,
        ),
        const SizedBox(height: 15),
        textFormField(
          validate: (value) {
            if (value.toString().isEmpty) {
              return notNull;
            }
            return validatePassword(value);
          },
          keyboardType: TextInputType.visiblePassword,
          prefix: Icons.password,
          obscureText: profileCubit.isSecure,
          suffixFunc: profileCubit.suffixFunction,
          label: confirmNewPassword,
          controller: confirmPasswordController,
        ),
        Row(
          children: [
            const Spacer(),
            TextButton(
                onPressed: () {
                  oldPasswordController.text = '';
                  newPasswordController.text = '';
                  confirmPasswordController.text = '';
                  Navigator.pop(buildContext);
                },
                child: Text(
                  cancel,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                )),
            TextButton(
              onPressed: () {
                if (bottomSheetFormKey.currentState!.validate()) {
                  profileCubit.changePassword(data: {
                    "oldPassword": oldPasswordController.text,
                    "newPassword": newPasswordController.text,
                    "confirmPassword": confirmPasswordController.text,
                  });
                }
              },
              child: Text(
               save,
                style: const TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: Colors.green,
                  textBaseline: TextBaseline.alphabetic,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  ),
);
