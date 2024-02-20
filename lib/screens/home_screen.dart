import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tomatopia/constant/carousal_items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  ClipPath(
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16,right: 40),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black)],
            ),
            width: 300,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.power_settings_new),
                      ),

                    ),
                    Container(
                      height: 90,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                Colors.orange,Colors.deepOrange,
                              ]
                          )
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/ahmed.png'),
                      ),

                    ),
                    const SizedBox(height: 5,),
                    const Text(
                      'Ahmed Abdelmoneim',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      'Ahmed ',
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
              style: TextStyle(
                fontSize: 20
              ),
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
                ),),
            // const SizedBox(
            //   height: 25,
            // ),
            // Container(
            //   height: 200,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.grey[200],
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Row(
            //     children: [
            //       Image.asset('assets/scan.jpg',)
            //     ],
            //   ),
            // )


          ],
        ),
      ),
    );
  }
}
