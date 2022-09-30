import 'package:flutter/material.dart';
import '../../business_logic/global_cubit/global_cubit.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({Key? key, required this.cubit}) : super(key: key);
  final GlobalCubit cubit;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 10,
        currentIndex: cubit.currentIndex,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          cubit.changePage(index: index);
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: Column(
              children: const [
                Icon(Icons.monetization_on, color: Colors.green),
                SizedBox(height: 5),
                CircleAvatar(radius: 4, backgroundColor: Colors.green)
              ],
            ),
            label: '',
            icon: const Icon(Icons.monetization_on, color: Colors.black),
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: const [
                  Icon(Icons.monetization_on, color: Colors.green),
                  SizedBox(
                    height: 5,
                  ),
                  CircleAvatar(radius: 4, backgroundColor: Colors.green)
                ],
              ),
            ),
            label: '',
            icon: const Icon(Icons.monetization_on, color: Colors.black),
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: const [
                  Icon(Icons.monetization_on, color: Colors.green),
                  SizedBox(
                    height: 5,
                  ),
                  CircleAvatar(radius: 4, backgroundColor: Colors.green)
                ],
              ),
            ),
            label: '',
            icon: const Icon(Icons.monetization_on, color: Colors.black),
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: const [
                  Icon(Icons.settings, color: Colors.green),
                  SizedBox(
                    height: 5,
                  ),
                  CircleAvatar(radius: 4, backgroundColor: Colors.green)
                ],
              ),
            ),
            label: '',
            icon: const Icon(Icons.settings, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
