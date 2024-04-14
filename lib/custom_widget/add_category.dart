import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
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
                    return "this filed can't be null";
                  }
                },
                keyboardType: TextInputType.name,
                prefix: Icons.category,
                label: 'add new category ',
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
                      child: const Text(
                        'cancel',
                        style: TextStyle(
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
                    child: const Text(
                      'save',
                      style: TextStyle(
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
  child: const Row(
    children: [
      Icon(
        FontAwesomeIcons.squarePlus,
        color: Colors.green,
      ),
      SizedBox(
        width: 3,
      ),
      Text(
        'new category',
        style: TextStyle(
          color: Colors.green,
        ),),
    ],
  ),
);