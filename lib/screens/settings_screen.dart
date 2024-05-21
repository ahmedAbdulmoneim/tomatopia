import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: const Color(0xFF039687),
                      child: const SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 60,
                                  backgroundImage: AssetImage('assets/ahmed.png')),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Ahmed Mohammad",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Notification Settings',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF87c8c1),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SwitchListTile(
                        value: true,
                        activeColor: const Color(0xFF039687),
                        title: const Text('Recived Notification'),
                        onChanged: (value){
                          print(value);
                        }),
                    const SizedBox(height: 10,),

                    Card(
                        elevation: 4.0,
                        color: Colors.white,
                        margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.lock_outline,
                                color: Color(0xFF039687),
                              ),
                              title: const Text("Change Password"),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change password
                              },
                            ),
                            const Divider(
                              endIndent: 8,
                              indent: 8,
                            ),
                            ListTile(
                              leading: const Icon(
                                FontAwesomeIcons.earthAfrica,
                                color: Color(0xFF039687),
                              ),
                              title: const Text("Change Language"),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change password
                              },
                            ),
                            const Divider(
                              endIndent: 8,
                              indent: 8,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.location_on,
                                color: Color(0xFF039687),
                              ),
                              title: const Text("Change Password"),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change password
                              },
                            ),
                          ],
                        )),



                  ]),
            ),
          )
        ],
      ),
    );
  }
}
