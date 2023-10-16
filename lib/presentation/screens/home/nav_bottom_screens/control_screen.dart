import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
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

  GlobalCubit _cubit(context) => BlocProvider.of<GlobalCubit>(context);

  List<Widget> _currentPage() => [
        const HomeScreen(),
        const ConfirmPayingScreen(),
        const ExpensesStatisticsScreen(),
        const IncomeStatisticsScreen(),
        const SettingsScreen()
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.dp),
                  child: CustomAppBar(
                    title: '${AppStrings.appBarTitle}${_cubit(context).currentIndex}'
                        .tr(),
                    onTapFirstIcon: () {
                      Scaffold.of(context).openDrawer();
                      _cubit(context).emitDrawer();
                    },
                    isEndIconVisible: _cubit(context).currentIndex == 4 ? false : true,
                    firstIcon: Icons.menu,
                    textStyle: _cubit(context).currentIndex == 1
                        ? Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: 15.dp)
                        : null,
                  ),
                ),
              ),
              Expanded(flex: 19, child: _currentPage()[_cubit(context).currentIndex]),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) => BottomNavBarWidget(
          cubit: _cubit(context),
        ),
      ),
    );
  }
}
