import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:tomatopia/custom_widget/text_form_filed.dart';

Widget editCategory({context, name, key, cubit, index}) => IconButton(
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
                label: 'edite category name ',
                controller: name,
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        name.text = '';
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
                        cubit.editeCategory(id:cubit.categoryList![index]['id'],newCategory: name.text);
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
  icon: const Icon(
    FontAwesomeIcons.penToSquare,
    color: Colors.blueAccent,
  ),
);