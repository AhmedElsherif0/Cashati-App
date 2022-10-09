import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
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
        // unselectedIconTheme: const IconThemeData(size: 40),
        elevation: 9,
        iconSize: 16.sp,
        currentIndex: cubit.currentIndex,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          cubit.changePage(index: index);
        },
        items: [

          BottomNavigationBarItem(
            activeIcon: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/dollar.svg',
                  color: Colors.green,
                ),
                const SizedBox(height: 5),
                const CircleAvatar(radius: 4, backgroundColor: Colors.green)
              ],
            ),
            label: '',
            icon: SvgPicture.asset('assets/icons/dollar.svg'),
          ),
          BottomNavigationBarItem(
            activeIcon: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/wallet.svg',
                  color: Colors.green,
                ),
                const SizedBox(height: 5),
                const CircleAvatar(radius: 4, backgroundColor: Colors.green)
              ],
            ),
            label: '',
            icon: SvgPicture.asset('assets/icons/wallet.svg'),
          ),
          BottomNavigationBarItem(
            activeIcon: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/glow_chart.svg',
                  color: Colors.green,
                ),
                const SizedBox(height: 5),
                const CircleAvatar(radius: 4, backgroundColor: Colors.green)
              ],
            ),
            label: '',
            icon: SvgPicture.asset('assets/icons/glow_chart.svg'),
          ),
          BottomNavigationBarItem(
            activeIcon: Column(
              children: [
                SvgPicture.asset('assets/icons/setting.svg',color: Colors.green,),
                const SizedBox(height: 5),
                const CircleAvatar(radius: 4, backgroundColor: Colors.green)
              ],
            ),
            label: '',
            icon: SvgPicture.asset('assets/icons/setting.svg'),
          ),
        ],
      ),
    );
  }
}
