import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:tomatopia/admin/admin_panel.dart';
import 'package:tomatopia/auth/login.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/cubit/ai_cubit/ai_model_cubit.dart';
import 'package:tomatopia/cubit/ai_cubit/ai_model_state.dart';
import 'package:tomatopia/cubit/home_cubit/home_cubit.dart';
import 'package:tomatopia/cubit/home_cubit/home_states.dart';
import 'package:tomatopia/cubit/profile/profile_cubit.dart';
import 'package:tomatopia/custom_widget/custom_button.dart';
import 'package:tomatopia/custom_widget/daily_weather.dart';
import 'package:tomatopia/custom_widget/extensions.dart';
import 'package:tomatopia/custom_widget/toasts.dart';
import 'package:tomatopia/notes/all_notes.dart';
import 'package:tomatopia/page_transitions/scale_transition.dart';
import 'package:tomatopia/screens/add_review.dart';
import 'package:tomatopia/screens/contact_us.dart';
import 'package:tomatopia/screens/forecast_weather.dart';
import 'package:tomatopia/screens/profile_screen.dart';
import 'package:tomatopia/screens/search_screen.dart';
import 'package:tomatopia/screens/settings_screen.dart';
import 'package:tomatopia/screens/tips.dart';
import 'package:tomatopia/screens/treatment_screen.dart';
import 'package:tomatopia/shared_preferences/shared_preferences.dart';

import '../cubit/profile/profile_states.dart';
import 'fertilisers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? disease;

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        disease = message.notification!.body;
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Search(
            diseaseName: disease,
          ),
        ),
      );
    });
    FirebaseMessaging.instance.getInitialMessage();

    super.initState();
  }

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
                const SizedBox(
                  height: 70,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                  ),
                  title: Text(context.profile),
                  onTap: () async {
                    await BlocProvider.of<ProfileCubit>(context)
                        .getUserProfile();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                  ),
                  title: Text(context.settings),
                  onTap: () async {
                    await BlocProvider.of<ProfileCubit>(context)
                        .getUserProfile();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.contacts_outlined,
                  ),
                  title: Text(context.contactSocial),
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
                  title: Text(context.aboutUs),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.rate_review_outlined,
                  ),
                  title: Text(context.addReview),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddReview(),
                        ));
                  },
                ),
                isAdmin == true
                    ? ListTile(
                        leading: const Icon(
                          Icons.admin_panel_settings_sharp,
                          color: Colors.blue,
                        ),
                        title: Text(context.adminPanel),
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
                  title: Text(context.logout),
                  onTap: () {
                    SharedPreference.removeData(key: 'token').then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    });
                    SharedPreference.removeData(key: 'isAdmin').then((value) {
                      isAdmin = false;
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
                  height: 35,
                ),
                BlocConsumer<HomeCubit, HomePageStates>(
                  listener: (context, state) {
                    if (state is GetAllTipsSuccessState) {
                      Navigator.push(
                          context,
                          SizeTransition1(ShowTips(
                            allTips:
                                BlocProvider.of<HomeCubit>(context).allTips,
                          )));
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, SizeTransition1(Search()));
                              },
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width / 2.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.greenAccent[100]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: const Icon(
                                          Icons.search,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        context.searchDisease,
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                await BlocProvider.of<HomeCubit>(context)
                                    .getAllTips();
                              },
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width / 2.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.greenAccent[100]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: const Icon(
                                          Icons.tips_and_updates,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        context.tipsForYou,
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    SizeTransition1(
                                        TomatoAgriculturePlanScreen()));
                              },
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width / 2.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.greenAccent[100]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: const Icon(
                                          Icons.calculate,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        context.fertilisers,
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NotesView(),
                                    ));
                              },
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width / 2.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.greenAccent[100]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: const Icon(
                                          Icons.note_add_outlined,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        context.notes,
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AiCubit, AiModelStates>(
                  listener: (context, state) {
                    print(state);
                    if (state is AiModelSuccessState) {
                      if (BlocProvider.of<AiCubit>(context)
                              .aiModel!
                              .prediction !=
                          "bad") {
                        if (BlocProvider.of<AiCubit>(context)
                                .aiModel!
                                .prediction !=
                            "healthy") {
                          BlocProvider.of<AiCubit>(context).getDiseaseInfo(
                              name: BlocProvider.of<AiCubit>(context)
                                  .diseaseNameArabic!);
                          BlocProvider.of<AiCubit>(context)
                              .navigateToGetMedicineScreen(
                                  context: context,
                                  page: GetMedicine(
                                      img: BlocProvider.of<AiCubit>(context)
                                          .imageFile!));
                        }
                      }
                      if (BlocProvider.of<AiCubit>(context)
                              .aiModel!
                              .prediction ==
                          "healthy") {
                        show(context, context.done, 'healthy plant',
                            Colors.green);
                      } else if (BlocProvider.of<AiCubit>(context)
                              .aiModel!
                              .prediction ==
                          "bad") {
                        show(context, context.error,
                            context.errorImageNotRecognized, Colors.deepOrange);
                      }
                    } else if (state is AiModelFailureState) {
                      show(context, context.error, context.errorHappened,
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
                                Text(context.takeAPicture)
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
                                Text(context.getMedicine)
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
                              text: context.takeAPicture,
                              onPressed: () {
                                cubit.clearSelectedImage();
                                AwesomeDialog(
                                  context: context,
                                  btnCancelOnPress: () async {
                                    await cubit.pickImageFromGallery();
                                    cubit.postData(imageFile: cubit.imageFile!);
                                  },
                                  btnOkOnPress: () async {
                                    await cubit.pickImageFromCamera(context);
                                    cubit.postData(imageFile: cubit.imageFile!);
                                  },
                                  isDense: true,
                                  btnOkText: context.camera,
                                  btnCancelText: context.gallery,
                                  btnCancelColor: Colors.lightBlueAccent,
                                  btnCancelIcon: Icons.image,
                                  btnOkIcon: Icons.camera_alt_outlined,
                                  title: context.choosePicture,
                                  desc: context.takePictureOrLoadIt,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
