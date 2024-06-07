import 'package:flutter/material.dart';
import 'package:tomatopia/constant/variables.dart';
import 'package:tomatopia/custom_widget/extensions.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double widthC = MediaQuery.of(context).size.width * 100;
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildMainInfo(context, widthC),
              const SizedBox(height: 10.0),
              _buildInfo(context, widthC),
            ],
          ),
        ));
  }

  Widget _buildHeader() {
    return Stack(
      children:[
        Ink(
          height: 200,
          decoration:  const BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage('assets/backimage.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.black38,
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 140),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: Colors.grey.shade500,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 6.0,
                    ),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: userImage != ''
                          ? Image.network(
                          '$basUrlImage$userImage',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover) :
                      Image.network(noImage)
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildMainInfo(BuildContext context, double width) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      alignment: AlignmentDirectional.center,
      child: Column(
        children: [
           Text(
               userName,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context, double width) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(15),
            child:  Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.teal),
                      title: Text(context.email),
                      subtitle: Text(userEmail),
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: const Icon(Icons.my_location, color: Colors.teal),
                      title: Text(context.location),
                      subtitle: const Text("Beni Suef"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
