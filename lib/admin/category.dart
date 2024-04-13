import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Category'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            children: [
              CupertinoSearchTextField(
                onSubmitted: (value){},
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.sizeOf(context).height,
                  child: ListView.separated(
                    itemBuilder: (context, index) => Row(
                      children: [
                        const Expanded(
                          child: Text(
                            '1. Tomatopia',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, fontStyle: FontStyle.italic),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              btnOkOnPress: () async {

                              },
                              btnCancelOnPress: () {},
                              btnCancelText: 'Cancel',
                              btnOkText: 'Delete',
                              btnCancelColor: Colors.green,
                              btnOkColor: Colors.red,
                              title: 'Are You Sure You Want To Delete This User .',
                              animType: AnimType.leftSlide,
                            ).show();
                          },
                          icon: const Icon(
                           FontAwesomeIcons.penToSquare,
                            color: Colors.blueAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => const Divider(height: 30),
                    itemCount: 20,
                  ),
                ),
              ),

            ]
        ),
      ),


    );
  }
}
