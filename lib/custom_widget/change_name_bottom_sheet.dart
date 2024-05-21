import 'package:flutter/material.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

Widget changeNameBottomSheetBuilder (
{
  required formKey,
  required context,
  required profileCubit,
  required nameController,
}
    )=> Form(
  key: formKey,
  child: Container(
    height: 200,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context)
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
          },
          keyboardType: TextInputType.name,
          prefix: Icons.person,
          label: 'enter new name ',
          controller: nameController,
        ),
        Row(
          children: [
            const Spacer(),
            TextButton(
                onPressed: () {
                  nameController.text =
                  '';
                  Navigator.pop(
                      context);
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(
                    color:
                    Colors.black54,
                  ),
                )),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()){
                  profileCubit.changeUserName(newName: nameController.text);

                }
              },
              child: const Text(
                'save',
                style: TextStyle(
                    color: Colors.green,
                    decoration:
                    TextDecoration
                        .underline,
                    decorationStyle:
                    TextDecorationStyle
                        .solid,
                    decorationColor:
                    Colors.green,
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