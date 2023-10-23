import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_cubit.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_state.dart';
import 'package:temp/presentation/screens/home/nav_bottom_screens/settings_screen.dart';
import 'package:temp/presentation/screens/home/nav_bottom_screens/statistics_expenses_screen.dart';
import 'package:temp/presentation/screens/home/nav_bottom_screens/statistics_income_screen.dart';
import 'package:temp/presentation/views/app_drawer.dart';

import '../../../../business_logic/cubit/global_cubit/global_cubit.dart';
import '../../../../constants/app_strings.dart';
import '../../../views/bottom_nav_bar.dart';
import '../../../widgets/custom_app_bar.dart';
import 'confirm_screen.dart';
import 'home_screens/home_screen.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  List<Widget> _currentPage() => [
        const HomeScreen(),
        const ConfirmPayingScreen(),
        const ExpensesStatisticsScreen(),
        const IncomeStatisticsScreen(),
        const SettingsScreen()
      ];

  @override
  Widget build(BuildContext context) {
    final globalCubit = context.read<GlobalCubit>();
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        appBar: AppBar(),
        drawer: const AppDrawer(),
        body: BlocBuilder<GlobalCubit, GlobalState>(
          builder: (context, state) => Column(
            children: [
              BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.dp),
                  child: CustomAppBar(
                    notificationsNumber:context.read<HomeCubit>().notificationList!=null? context.read<HomeCubit>().notificationList!.where((element) => element.didTakeAction==false).toList().length.toString():"0",
                    title: '${AppStrings.appBarTitle}${_cubit(context).currentIndex}'
                        .tr(),
                    onTapFirstIcon: () {
                      Scaffold.of(context).openDrawer();
                      globalCubit.emitDrawer();
                    },
                    isEndIconVisible: globalCubit.currentIndex == 4 ? false : true,
                    firstIcon: Icons.menu,
                    textStyle: globalCubit.currentIndex == 1
                        ? Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: 15.dp)
                        : null,
                  ),
                ),
              ),
              Expanded(
                  flex: orientation == Orientation.portrait ? 19 : 8,
                  child: _currentPage()[globalCubit.currentIndex]),

            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<GlobalCubit, GlobalState>(
          builder: (context, state) => BottomNavBarWidget(
            cubit: globalCubit,
          ),
        ),
      ),
    );
  }
}
