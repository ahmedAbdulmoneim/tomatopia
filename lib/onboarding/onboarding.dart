// import 'package:flutter/material.dart';
// import 'package:flutter_overboard/flutter_overboard.dart';
// import 'package:tomatopia/auth/login.dart';
//
//
//
//
//
// class OnBoarding extends StatelessWidget {
//   // ... (your pages list)
//   final pages = [
//     PageModel.withChild(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               'Take a photo',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30,
//                   decoration: TextDecoration.none,
//                   color: Colors.black),
//             ),
//             const SizedBox(height: 20),
//             Image.asset('assets/scan.png', width: 300.0, height: 300.0),
//             const SizedBox(height: 20),
//             const Text(
//               'Receive instant identifications and treatment suggestions',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   decoration: TextDecoration.none,
//                   fontStyle: FontStyle.italic),
//             ),
//           ],
//         ),
//       ),
//       color: Colors.white,
//       doAnimateChild: true,
//     ),
//     PageModel.withChild(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               'Search',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30,
//                   decoration: TextDecoration.none,
//                   color: Colors.black),
//             ),
//             const SizedBox(height: 20),
//             Image.asset('assets/search.png', width: 300.0, height: 300.0),
//             const SizedBox(height: 20),
//             const Text(
//               'Search for disease in your plant',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   decoration: TextDecoration.none,
//                   fontStyle: FontStyle.italic),
//             ),
//           ],
//         ),
//       ),
//       color: Colors.white,
//       doAnimateChild: true,
//     ),
//     PageModel.withChild(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               'Predict problems',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30,
//                   decoration: TextDecoration.none,
//                   color: Colors.black),
//             ),
//             const SizedBox(height: 20),
//             Image.asset('assets/alert.png', width: 300.0, height: 300.0),
//             const SizedBox(height: 20),
//             const Text(
//               'Receive alerts and apply preventative measures',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   decoration: TextDecoration.none,
//                   fontStyle: FontStyle.italic),
//             ),
//           ],
//         ),
//       ),
//       color: Colors.white,
//       doAnimateChild: true,
//     ),
//     PageModel.withChild(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               'Treatment',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30,
//                   decoration: TextDecoration.none,
//                   color: Colors.black),
//             ),
//             const SizedBox(height: 20),
//             Image.asset('assets/treatment.jpg', width: 300.0, height: 300.0),
//             const SizedBox(height: 20),
//             const Text(
//               'Get the best treatment for your plant',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   decoration: TextDecoration.none,
//                   fontStyle: FontStyle.italic),
//             ),
//           ],
//         ),
//       ),
//       color: Colors.white,
//       doAnimateChild: true,
//     ),
//     PageModel.withChild(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               'Community',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30,
//                   decoration: TextDecoration.none,
//                   color: Colors.black),
//             ),
//             const SizedBox(height: 20),
//             Image.asset('assets/cmmunity.png', width: 300.0, height: 300.0),
//             const SizedBox(height: 20),
//             const Text(
//               'Supportive Farming Community',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   decoration: TextDecoration.none,
//                   fontStyle: FontStyle.italic),
//             ),
//           ],
//         ),
//       ),
//       color: Colors.white,
//       doAnimateChild: true,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return OverBoard(
//       pages: pages.map((page) => PageModel.withChild(
//         // Modifications to each page
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Colors.white, Colors.greenAccent],
//               stops: [0.5, 1.0], // Adjust gradient stops as needed
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0), // Equal padding on all sides
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center( // Center the text
//                   child: Text(
//                     page.child.children[0].child as String, // Get title text
//                     style: GoogleFonts.montserrat( // Example font
//                       fontWeight: FontWeight.bold,
//                       fontSize: 32,
//                       color: Colors.black,
//                     ),
//                     textAlign: TextAlign.center, // Center align text
//                   ),
//                 ),
//                 SizedBox(height: 30), // Space above the image
//                 ClipRRect( // Round the image corners
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: Image.asset(
//                     (page.child.children[1] as Image).image.assetName, // Get image
//                     width: 300.0,
//                     height: 300.0,
//                   ),
//                 ),
//                 SizedBox(height: 30), // Space below the image
//                 Center( // Center the description text
//                   child: Text(
//                     page.child.children[2].child as String, // Get description text
//                     style: GoogleFonts.roboto( // Example font
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontStyle: FontStyle.italic,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         color: Colors.transparent, // Make container background transparent
//         doAnimateChild: true,
//       )).toList(), // Convert back to List<PageModel>
//
//       // ... (your other OverBoard settings)
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:tomatopia/auth/login.dart';
import 'package:tomatopia/shared_preferences/shared_preferences.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);

  final pages = [
    PageModel.withChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Take a photo',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/scan.png', width: 300.0, height: 300.0),
            const SizedBox(height: 20),
            const Text(
              'Receive instant identifications and treatment suggestions',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      color: Colors.white,
      doAnimateChild: true,
    ),
    PageModel.withChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Search',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/search.png', width: 300.0, height: 300.0),
            const SizedBox(height: 20),
            const Text(
              'Search for disease in your plant',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      color: Colors.white,
      doAnimateChild: true,
    ),
    PageModel.withChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Predict problems',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/alert.png', width: 300.0, height: 300.0),
            const SizedBox(height: 20),
            const Text(
              'Receive alerts and apply preventative measures',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      color: Colors.white,
      doAnimateChild: true,
    ),
    PageModel.withChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Treatment',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/treatment.jpg', width: 300.0, height: 300.0),
            const SizedBox(height: 20),
            const Text(
              'Get the best treatment for your plant',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      color: Colors.white,
      doAnimateChild: true,
    ),
    PageModel.withChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Community',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/cmmunity.png', width: 300.0, height: 300.0),
            const SizedBox(height: 20),
            const Text(
              'Supportive Farming Community',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      color: Colors.white,
      doAnimateChild: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return OverBoard(
      pages: pages,
      allowScroll: true,
      inactiveBulletColor: Colors.grey,
      activeBulletColor: Colors.greenAccent,
      finishCallback: () {
       submit(context);
      },
      showBullets: true,
      skipCallback: () {
        submit(context);
      },
      skipText: 'SKIP',
      finishText: 'DONE',
      nextText: 'NEXT',
      buttonColor: Colors.black,
    );
  }
}
void submit(context){
  SharedPreference.saveData(key: "onBoarding", value: 'done').then((value){
    if(value){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    }
  });
}

