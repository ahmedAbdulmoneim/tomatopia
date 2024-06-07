import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

Widget addCategory(context,key,newCat,addCat) => TextButton(
  onPressed: () {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Form(
        key: key,
        child: Container(
          height: 200,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20,
              left: 10,
              right: 10),
          child: Column(
            children: [
              textFormField(
                validate: (value) {
                  if (value.toString().isEmpty) {
                    return context.thisFieldCannotBeNull;
                  }
                },
                keyboardType: TextInputType.name,
                prefix: Icons.category,
                label: context.addNewCategory,
                controller: newCat,
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        newCat.text = '';
                        Navigator.pop(context);
                      },
                      child:  Text(
                        'cancel'.tr(),
                        style: const TextStyle(
                          color:
                          Colors.black54,
                        ),
                      )),
                  TextButton(
                    onPressed: () {
                      if (key.currentState!.validate()){
                        addCat.addCategory(newCategory: newCat.text);
                        Navigator.pop(context);
                      }
                    },
                    child:  Text(
                      'save'.tr(),
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
      ),
    );
  },
  child:  Row(
    children: [
      const Icon(
        FontAwesomeIcons.squarePlus,
        color: Colors.green,
      ),
      const SizedBox(
        width: 8,
      ),
      Text(
        'add_new_category'.tr(),
        style: const TextStyle(
          color: Colors.green,
        ),),
    ],
  ),
);