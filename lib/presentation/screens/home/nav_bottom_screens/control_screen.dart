import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/views/app_drawer.dart';

import '../../../../business_logic/cubit/global_cubit/global_cubit.dart';
import '../../../views/bottom_nav_bar.dart';
import '../../../widgets/custom_app_bar.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  GlobalCubit _cubit(context) => BlocProvider.of<GlobalCubit>(context);

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
                  padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                  child: CustomAppBar(
                    title: _cubit(context).appBarTitle[_cubit(context).currentIndex],
                    onTapFirstIcon: () => _cubit(context).emitDrawer(context),
                    // onTapNotification: () {
                    //   print('notification tapped');
                    //   Navigator.pushNamed(context, AppRouterNames.rNotificationTest);
                    // },
                    isEndIconVisible: _cubit(context).currentIndex == 4 ? false : true,
                    firstIcon: Icons.menu,
                    textStyle: _cubit(context).currentIndex == 1
                        ? Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: 15.sp)
                        : null,
                  ),
                ),
              ),
              Expanded(
                  flex: 19,
                  child: _cubit(context).nextPage[_cubit(context).currentIndex]),
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
