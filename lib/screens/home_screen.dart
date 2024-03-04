import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatopia/constant/carousal_items.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';
import 'package:tomatopia/screens/treatment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TOMATOPIA',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'popular disease',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            CarouselSlider(
              items: carousalItems,
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInBack,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              height: 250,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: Colors.black26, offset: Offset(0.3, 3)),
                  BoxShadow(color: Colors.black12, offset: Offset(3, 0.3)),
                  BoxShadow(color: Colors.black12, offset: Offset(-3, 0.3)),
                  BoxShadow(color: Colors.black12, offset: Offset(0.3, -3)),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Column(children: [
                Row(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/home_images/take_pic.png',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Take picture')
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 45.0),
                      child: Icon(Icons.navigate_next_sharp, size: 75),
                    ),
                    Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/home_images/medicine.png',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Get medicine')
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                customButton(
                    text: 'Take a picture',
                    onPressed: ()  {
                      clearSelectedImage();
                      AwesomeDialog(
                          context: context,
                        btnCancelOnPress: ()async{
                            await picImageFromGallery();
                           navigateToGetMedicineScreen();
                        },
                        btnOkOnPress: ()async{
                           await picImageFromCamera();
                           navigateToGetMedicineScreen();

                        },
                          isDense: true,
                          btnOkText: 'Camera',
                          btnCancelText: 'Gallery',
                          btnCancelColor: Colors.lightBlueAccent,
                          btnCancelIcon: Icons.image,
                          btnOkIcon: Icons.camera_alt_outlined,
                        title: 'Choose picture',
                        desc: 'Take a picture or Load it ',
                        dialogType: DialogType.question,

                      ).show();



                    }),
              ]),
            ),
          ],
        ),
      ),
    );
  }
  void navigateToGetMedicineScreen() {
    if (selectedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetMedicine(
            img: selectedImage!,
          ),
        ),
      );
    }
  }
  Future picImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  Future picImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  void clearSelectedImage() {
    setState(() {
      selectedImage = null;
    });
  }
}
