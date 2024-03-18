import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: const Text('Contact & Social'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 20, bottom: 10),
            child: Text(
              'Social Media',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.facebook,
              size: 50,
              color: Color(0xFF0965A9),
            ),
            title: Text('Facebook'),
          ),
          Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.youtube,
              size: 50,
              color: Color(0xFFEC1C34),
            ),
            title: Text('Youtube'),
          ),
          Divider(
            endIndent: 20,
            indent: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 20, bottom: 10),
            child: Text(
              'Contact Us ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.mark_email_read_outlined,
              size: 25,
              color: Colors.black,
            ),
            title: Text('send us an e-mail'),
          ),
          Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.link,
              size: 25,
              color: Colors.black,
            ),
            title: Text('Visit our website'),
          ),
        ],
      ),
    );
  }
}
