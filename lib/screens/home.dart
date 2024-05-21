import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatopia/cubit/home_cubit/home_cubit.dart';
import '../cubit/home_cubit/home_states.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomePageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return Scaffold(
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: cubit.currentIndex,
            itemCornerRadius: 15,
            curve: Curves.easeInBack,
            items: [
              BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: const Text(
                  'Home',
                ),
                activeColor: Colors.green,
                inactiveColor: Colors.black,
              ),
              BottomNavyBarItem(
                  activeColor: Colors.deepOrange,
                  inactiveColor: Colors.black,
                  icon: const Icon(Icons.chat_outlined),
                  title: const Text('Community')),
              BottomNavyBarItem(
                  activeColor: Colors.red,
                  inactiveColor: Colors.black,
                  icon: const Icon(Icons.crisis_alert),
                  title: const Text('Alert')),
            ],
            onItemSelected: (value) {
              cubit.onSelectedItem(value: value);
              if(value == 1){
                cubit.getAllPost();
              }
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },

    );
  }
}
