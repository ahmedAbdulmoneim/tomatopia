import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tomatopia/cubit/weather/weather_cubit.dart';

import '../cubit/weather/weather_states.dart';

class ForecastWeather extends StatelessWidget {
  const ForecastWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherStates>(builder: (context, state) {
        var cubit = BlocProvider.of<WeatherCubit>(context).weatherModel;
        if (state is GetWeatherFailureState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: cubit!.dates.length,
          itemBuilder: (context, index) => Card(
            elevation: 6,
            margin:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            color: Colors.white,
            child: Container(
              height: 250,
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.dates[index],
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${DateFormat('EEEE').format(DateTime.parse(cubit.dates[index]))}, ${cubit.weatherConditions[index]}',
                    ),
                    Row(
                      children: [
                        Text(
                          '${cubit.temps[index].toInt()} °C',
                          style: const TextStyle(
                              fontSize: 45, fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        Image.network(
                          cubit.images[index].contains('https:')
                              ? cubit.images[index]
                              : 'https:${cubit.images[index]}',
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.cloudy_snowing,
                              color: Colors.blue,
                              size: 40,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text('${cubit.rains[index].toInt()} % Rains')
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            const Icon(
                              Icons.wind_power,
                              color: Colors.blue,
                              size: 40,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text('${cubit.winds[index].toInt()} km/h Winds')
                          ],
                        ),
                      ],
                    ),
                    const Spacer()
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
