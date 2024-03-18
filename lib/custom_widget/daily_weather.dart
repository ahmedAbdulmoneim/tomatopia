import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tomatopia/cubit/weather/weather_cubit.dart';

import '../cubit/weather/weather_states.dart';

Widget dailyWeather() => Container(
    padding: const EdgeInsets.only(left: 20, right: 10),
    height: 100,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(50),
      border: const Border(
        top: BorderSide(
          color: Colors.black,
          width: 2,
          strokeAlign: 1,
        ),
        bottom: BorderSide(
          color: Colors.black,
          width: 3,
          strokeAlign: 1,
        ),
      ),
    ),
    child: BlocConsumer<WeatherCubit, WeatherStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<WeatherCubit>(context).weatherModel;
          if (state is GetWeatherSuccessState) {
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${cubit!.cityPronunciation},${DateFormat('dd MMM').format(DateTime.parse(cubit.dates[0]))}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${cubit.currentCondition} . ${cubit.maxTemps[0].toInt()} °C / ${cubit.minTemps[0].toInt()} °C',
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  '${cubit.currentTemp.toInt()} °C ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Image.network(
                  cubit.images[0].contains('https:')
                      ? cubit.images[0]
                      : 'https:${cubit.images[0]}',
                ),
              ],
            );
          }
          if (state is GetWeatherFailureState) {
            BlocProvider.of<WeatherCubit>(context).getWeatherData('beni suef');
            return const Row(
              children: [
                Text(
                  'cheek internet',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
        }));
