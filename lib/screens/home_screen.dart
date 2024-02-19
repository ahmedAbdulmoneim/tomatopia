import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: Colors.white,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TOMATOPIA',
        ),
      ),
      body: const Center(
        child: Text('HOME Screen'),
      ),
    );
  }
}
