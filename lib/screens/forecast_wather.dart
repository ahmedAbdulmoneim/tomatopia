
import 'package:flutter/material.dart';

class ForecastWeather extends StatelessWidget {
  const ForecastWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Card(
          elevation: 6,

          margin:
              const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
          color: Colors.white,
          child: Container(
            height: 250,
            color: Colors.white,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cairo',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Monday, mostly sunny',
                  ),
                  Row(
                    children: [
                      Text(
                        '25 °C',
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      Icon(
                        Icons.sunny,
                        size: 75,
                        color: Colors.yellowAccent,
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.cloudy_snowing,
                            color: Colors.blue,
                            size: 40,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text('2% Rainy')
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Icon(
                            Icons.wind_power,
                            color: Colors.blue,
                            size: 40,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text('2 km/h Winds')
                        ],
                      ),
                    ],
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
