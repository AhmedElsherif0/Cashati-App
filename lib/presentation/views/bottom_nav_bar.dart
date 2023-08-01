import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/constants/app_icons.dart';

import '../../business_logic/cubit/global_cubit/global_cubit.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final GlobalCubit cubit;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.dp,
            blurRadius: 4.dp,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: BottomNavigationBar(
        // unselectedIconTheme: const IconThemeData(size: 40),
        elevation: 4.dp,
        iconSize: 30.dp,
        currentIndex: cubit.currentIndex,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (index) => cubit.changePage(index: index),
        items: [
          bottomNavBarItem(AppIcons.navDollarSign),
          bottomNavBarItem(AppIcons.navGlowChart),
          bottomNavBarItem(AppIcons.navIncomeWallet),
          bottomNavBarItem(AppIcons.navExpenseWallet),
          bottomNavBarItem(AppIcons.navSettings),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomNavBarItem(String svgAsset) => BottomNavigationBarItem(
        activeIcon: Column(
          children: [
            SvgPicture.asset(svgAsset, color: Colors.green, height: 24.dp),
            const SizedBox(height: 5),
            const CircleAvatar(radius: 4, backgroundColor: Colors.green)
          ],
        ),
        label: '',
        icon: SvgPicture.asset(svgAsset),
      );
}
