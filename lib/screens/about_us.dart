// import 'package:flutter/material.dart';
//
// class AboutUs extends StatelessWidget {
//   const AboutUs({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('About Us'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: const [
//
//             SectionTitle(title: 'Flutter Team'),
//             TeamMember(name: 'Ahmed Mohammad Abdelmoneim'),
//             TeamMember(name: 'Frank Brown'),
//             SizedBox(height: 16.0),
//             SectionTitle(title: 'Machine Learning'),
//             TeamMember(name: 'Alice Smith'),
//             TeamMember(name: 'Bob Johnson'),
//             SizedBox(height: 16.0),
//             SectionTitle(title: 'Backend Team'),
//             TeamMember(name: 'Charlie Davis'),
//             TeamMember(name: 'Dana Williams'),
//             SizedBox(height: 16.0),
//             SectionTitle(title: 'Web Developer Team'),
//             TeamMember(name: 'Grace Lee'),
//             TeamMember(name: 'Henry Wilson'),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SectionTitle extends StatelessWidget {
//   final String title;
//
//   const SectionTitle({required this.title, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }
//
// class TeamMember extends StatelessWidget {
//   final String name;
//
//   const TeamMember({required this.name, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         name,
//         style: const TextStyle(
//           fontSize: 16.0,
//         ),
//       ),
//     );
//   }
// }
