import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

import '../constant/validate_password.dart';

Widget changePasswordBottomSheetBuilder ({
  required bottomSheetFormKey,
  required context,
  required confirmPasswordController,
  required oldPasswordController,
  required newPasswordController,
  required profileCubit,
})=> Form(
  key: bottomSheetFormKey,
  child: Container(
    height: 350,
    margin: EdgeInsets.only(
        bottom:
        MediaQuery.of(context)
            .viewInsets
            .bottom,
        top: 20,
        left: 10,
        right: 10),
    child: Column(
      children: [
        textFormField(
          validate: (value) {
            if (value
                .toString()
                .isEmpty) {
              return "this filed can't be null";
            }
            return validatePassword(
                value);
          },
          keyboardType:
          TextInputType
              .visiblePassword,
          obscureText:
          profileCubit
              .isSecure,
          prefix: Icons.password,
          suffix: profileCubit
              .suffixIcon,
          suffixFunc: profileCubit
              .suffixFunction,
          label:
          'enter old password',
          controller:
          oldPasswordController,
        ),
        const SizedBox(
          height: 15,
        ),
        textFormField(
          validate: (value) {
            if (value
                .toString()
                .isEmpty) {
              return "this filed can't be null";
            }
            return validatePassword(
                value);
          },
          keyboardType:
          TextInputType
              .visiblePassword,
          prefix: Icons.password,
          obscureText:
          profileCubit
              .isSecure,
          label:
          'enter new password',
          controller:
          newPasswordController,
        ),
        const SizedBox(
          height: 15,
        ),
        textFormField(
          validate: (value) {
            if (value
                .toString()
                .isEmpty) {
              return "this filed can't be null";
            }
            return validatePassword(
                value);
          },
          keyboardType:
          TextInputType
              .visiblePassword,
          prefix: Icons.password,
          obscureText:
          profileCubit
              .isSecure,
          suffixFunc: profileCubit
              .suffixFunction,
          label:
          'confirm new password',
          controller:
          confirmPasswordController,
        ),
        Row(
          children: [
            const Spacer(),
            TextButton(
                onPressed: () {
                  oldPasswordController
                      .text = '';
                  newPasswordController
                      .text = '';
                  confirmPasswordController
                      .text = '';
                  Navigator.pop(
                      context);
                },
                child: const Text(
                  'cancel',
                  style:
                  TextStyle(
                    color: Colors
                        .black54,
                  ),
                )),
            TextButton(
              onPressed: () {
                if (bottomSheetFormKey
                    .currentState!
                    .validate()) {
                  profileCubit
                      .changePassword(
                      data: {
                        "oldPassword":
                        oldPasswordController
                            .text,
                        "newPassword":
                        newPasswordController
                            .text,
                        "confirmPassword":
                        confirmPasswordController
                            .text,
                      });
                }
              },
              child: const Text(
                'save',
                style: TextStyle(
                    color: Colors
                        .green,
                    decoration:
                    TextDecoration
                        .underline,
                    decorationStyle:
                    TextDecorationStyle
                        .solid,
                    decorationColor:
                    Colors
                        .green,
                    textBaseline:
                    TextBaseline
                        .alphabetic,
                    fontSize: 18),
              ),
            ),
          ],
        )
      ],
    ),
  ),
);