import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatopia/admin/admin_panel.dart';
import 'package:tomatopia/auth/login.dart';
import 'package:tomatopia/constant/carousal_items.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/ai_cubit/ai_model_cubit.dart';
import 'package:tomatopia/cubit/ai_cubit/ai_model_state.dart';
import 'package:tomatopia/cubit/profile/profile_cubit.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';
import 'package:tomatopia/custom_widget/daily_weather.dart';
import 'package:tomatopia/custom_widget/toasts.dart';
import 'package:tomatopia/screens/contact_us.dart';
import 'package:tomatopia/screens/forecast_weather.dart';
import 'package:tomatopia/screens/profile_screen.dart';
import 'package:tomatopia/screens/treatment_screen.dart';
import 'package:tomatopia/shared_preferences/shared_preferences.dart';
import '../cubit/profile/profile_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TOMATOPIA',
        ),
      ),
      drawer: BlocBuilder<ProfileCubit, ProfileStates>(
        builder: (context, state) {
          return Drawer(
            width: 250,
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFF9CECBF)),
                  accountName: Text(
                    BlocProvider.of<ProfileCubit>(context).newName == null
                        ? userName
                        : BlocProvider.of<ProfileCubit>(context).newName!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  accountEmail: Text(
                    userEmail,
                    style:
                    const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage('assets/ahmed.png'),
                  ),
                  currentAccountPictureSize: const Size.fromRadius(40),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                  ),
                  title: const Text('Profile'),
                  onTap: () async {
                    Navigator.pop(context);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                  ),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.contacts_outlined,
                  ),
                  title: const Text('Contact & Social'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactUs(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.circleInfo,
                  ),
                  title: const Text('About us'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                userEmail == 'Admin@gamil.com'
                    ? ListTile(
                        leading: const Icon(
                          Icons.admin_panel_settings_sharp,
                          color: Colors.blue,
                        ),
                        title: const Text('Admin Panel'),
                        onTap: () async {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdminPanel(),
                              ));
                        },
                      )
                    : const SizedBox(),
                const Spacer(),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.powerOff,
                  ),
                  title: const Text('Logout'),
                  onTap: () {
                    SharedPreference.removeData(key: 'token').then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Column(
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
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeInBack,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                BlocConsumer<AiCubit, AiModelStates>(
                  listener: (context, state) {
                    if (state is AiModelSuccessState) {
                      // BlocProvider.of<AiCubit>(context).navigateToGetMedicineScreen(
                      //     context: context,
                      //     page: GetMedicine(img: BlocProvider.of<AiCubit>(context).imageFile!)
                      // );
                    } else if (state is AiModelFailureState) {
                      show(context, 'Error', "Image can't be recognized",
                          Colors.red);
                    }
                  },
                  builder: (context, state) {
                    var cubit = BlocProvider.of<AiCubit>(context);
                    return Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 50),
                      height: 250,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26, offset: Offset(0.3, 3)),
                          BoxShadow(
                              color: Colors.black12, offset: Offset(3, 0.3)),
                          BoxShadow(
                              color: Colors.black12, offset: Offset(-3, 0.3)),
                          BoxShadow(
                              color: Colors.black12, offset: Offset(0.3, -3)),
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
                        ConditionalBuilder(
                          condition: state is AiModelLoadingState,
                          builder: (context) => const LinearProgressIndicator(
                            color: Colors.green,
                          ),
                          fallback: (context) => customButton(
                              text: 'Take a picture',
                              onPressed: () {
                                cubit.clearSelectedImage();
                                AwesomeDialog(
                                  context: context,
                                  btnCancelOnPress: () async {
                                    await cubit.picImageFromGallery();
                                    cubit.postData(formData: cubit.formData!);


                                  },
                                  btnOkOnPress: () async {
                                    await cubit.picImageFromCamera();
                                    cubit.postData(formData: cubit.formData!);

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
                        ),
                      ]),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForecastWeather(),
                          ));
                    },
                    child: dailyWeather()),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
